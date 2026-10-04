[
  {
    src = ./create-readme;
    description = "Create a new README.md file according to best practices and a useful template";
    harnessSpecific = {
      claude = {
        model = "Claude Haiku 4.5";
      };
    };
  }
]
