{ fetchHelpers, ... }:
let
  claude = {
    smallModel = "Claude Haiku 4.5";
  };
in
[
  {
    src = ./create-readme;
    description = "Create a new README.md file according to best practices and a useful template";
    harnessSpecific = {
      claude = {
        model = claude.smallModel;
      };
    };
  }
  {
    src = ./write-issue;
    description = "Write an issue/ticket for the current project";
    harnessSpecific = {
      claude = {
        model = claude.smallModel;
      };
    };
  }
  {
    src = ./grill-me;
    description = "Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.";
  }
  {
    src = ./bisect-helper;
    description = "Automate a git bisect run to find the commit that introduced a regression";
  }
  {
    src = ./explain-ci-failure;
    description = "Explain why a CI run failed and point at the responsible commit/line";
  }
  {
    src = fetchHelpers.fetchFromGitSrc {
      name = "docling";
      url = "https://github.com/docling-project/docling";
      rev = "3181d9fcbb8b7568ceba14b7ed5cd21f66b221e7";
      rootDir = "docling/.agents/skills/docling";
      hash = "sha256-1Vb/dG/bYvZ8l+4meDNqjGSYqpP0B4iqHNbLxwtYli4=";
    };
    description = ''
      Use Docling to understand the content of documents in any supported format — PDF (born-digital or scanned), DOCX, PPTX, XLSX, HTML, Markdown, AsciiDoc, CSV, images, audio, and XML — by converting them into a unified DoclingDocument (Markdown or structured JSON). 
      Use this skill whenever you need to read, parse, convert, extract, or chunk a document you cannot read directly.
    '';
  }
]
