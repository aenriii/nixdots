_: {
  programs.git = {
    enable = true;
    userName = "Aenri Lovehart";
    userEmail = "aenri@loveh.art";
    extraConfig = {
      init = {defaultBranch = "main";};
      core.editor = "nvim";
      pull.rebase = false;
    };
  };
}
