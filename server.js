import { serve } from "std/http/server.ts";
import { serveDir } from "std/http/file_server.ts";
import { setup } from "twind";
import { getStyleTag, shim, virtualSheet } from "twind/shim/server";
import { app } from "./build/dev/javascript/gitcove/gitcove.mjs";

const sheet = virtualSheet();
setup({
  theme: {
    extend: {
      colors: {
        primary: "rgb(75, 107, 251)",
        "primary-focus": "rgb(11, 55, 250)",
        "primary-content": "rgb(218, 225, 255)",

        secondary: "rgb(123, 146, 178)",
        "secondary-focus": "rgb(89, 115, 152)",
        "secondary-content": "rgb(0, 25, 60)",

        accent: "rgb(103, 203, 160)",
        "accent-focus": "rgb(62, 182, 131)",
        "accent-content": "rgb(0, 61, 35)",

        neutral: "rgb(24, 26, 42)",
        "neutral-focus": "rgb(19, 21, 34)",
        "neutral-content": "rgb(237, 242, 247)",

        "base-100": "rgb(255, 255, 255)",
        "base-200": "rgb(230, 230, 230)",
        "base-300": "rgb(207, 207, 207)",
        "base-content": "rgb(24, 26, 42)",

        info: "rgb(58, 191, 248)",
        "info-content": "rgb(0, 43, 61)",

        success: "rgb(54, 211, 153)",
        "success-content": "rgb(0, 51, 32)",

        warning: "rgb(251, 189, 35)",
        "warning-content": "rgb(56, 40, 0)",

        error: "rgb(248, 114, 114)",
        "error-content": "rgb(71, 0, 0)",
      },
    },
  },
  sheet,
});

await serve((request) => {
  const pathname = new URL(request.url).pathname;

  if (pathname.startsWith("/static")) {
    return serveDir(request, {
      fsRoot: "./",
    });
  }

  sheet.reset();

  const rendered = app(request.url);
  const shimmed = shim(rendered);
  const styleTag = getStyleTag(sheet);

  return new Response(shimmed.replace('<meta name="twind" />', styleTag), {
    headers: {
      "content-type": "text/html; charset=utf-8",
    },
  });
});
