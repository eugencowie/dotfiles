{ den, inputs, ... }: {

  den.aspects.browser.provides.zen.homeManager = {

    imports = [ inputs.zen-browser.homeModules.beta ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
    };

  };

}
