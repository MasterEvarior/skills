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
]
