{ fetchHelpers, ... }:
let
  claude = {
    smallModel = "Claude Haiku 4.5";
  };
  addCompatibility = set: { compatibility = "opencode"; } // set;
  addCompatibility' = addCompatibility { };
in
[
  {
    src = ./create-readme;
    description = "Create a new README.md file according to best practices and a useful template";
    harnessSpecific = {
      claude = {
        model = claude.smallModel;
      };
      opencode = addCompatibility {
        metadata.audience = "developers, maintainers";
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
      opencode = addCompatibility {
        metadata.audience = "developers, maintainers";
      };
    };
  }
  {
    src = ./grill-me;
    description = "Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.";
    harnessSpecific = {
      opencode = addCompatibility {
        metadata.audience = "developers, maintainers, reviewers";
      };
    };
  }
  {
    src = ./bisect-helper;
    description = "Automate a git bisect run to find the commit that introduced a regression";
    harnessSpecific = {
      opencode = addCompatibility {
        metadata.audience = "developers, maintainers";
      };
    };
  }
  {
    src = ./explain-ci-failure;
    description = "Explain why a CI run failed and point at the responsible commit/line";
    opencode = addCompatibility {
      metadata.audience = "reviewers";
    };
  }
  {
    src = ./writing-feedback;
    description = "Give feedback for something written: a blog-post, a paper, ...";
    harnessSpecific = {
      claude = {
        model = claude.smallModel;
      };
      opencode = addCompatibility {
        metadata.audience = "reviewers";
      };
    };
  }
  {
    src = ./review;
    description = "Review a PR or some code changes in comparison to another branch";
    harnessSpecific = {
      opencode = addCompatibility {
        metadata.audience = "reviewers, developers, maintainers";
      };
    };
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
    harnessSpecific = {
      opencode = addCompatibility';
    };
  }
  {
    src = fetchHelpers.fetchFromGitSrc {
      name = "sidekick";
      url = "https://github.com/ZanderHammer/sidekick";
      rev = "2cc4759c7f9a2ad3e35ab63bf1876cff220c898f";
      hash = "sha256-W2hyBEmWigebezBn4T8IJRM0L5bSb/Ui0SLWzo3i6/8=";
    };
    description = ''
      Keep the user actively involved in coding projects: sketch approaches with trade-offs instead of delivering complete implementations, give staged hints for debugging rather than direct fixes, and manage lightweight project planning (VISION/BACKLOG/SPRINT/RESEARCH) in a sidekick/ folder.
      Use when the user wants a collaborative coding partner rather than an autopilot, or asks for sketches, staged hints, or lightweight project planning.
    '';
    harnessSpecific = {
      opencode = addCompatibility';
      claude = {
        disable-model-invocation = true;
      };
    };
  }
  {
    src = fetchHelpers.fetchFromGitSrc {
      name = "slidev";
      url = "https://github.com/slidevjs/slidev";
      rev = "b610bdfe10f4e33ff5a47a78c39614618a709f31";
      rootDir = "skills/slidev";
      hash = "sha256-thYZZCxSJpv5DTMzcGVmx8PkmQeGhVAJVUwafaiwF4E=";
    };
    description = ''
      Create and present web-based slidedecks for developers using Slidev with Markdown, Vue components, code highlighting, animations, and interactive features.
      Use when building technical presentations, conference talks, code walkthroughs, teaching materials, or developer decks.
    '';
    harnessSpecific = {
      opencode = addCompatibility';
    };
  }
]
