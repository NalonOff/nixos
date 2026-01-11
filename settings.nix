{
  # User settings
  user = {
    username = "nalon";
    fullName = "Nalon";
    email = "nalonof@gmail.com";
    country = "FRANCE"; # Upper case only
    city = "Tarbes";
  };

  # System settings
  system = {
    hostname = "nixos";
    timezone = "Europe/Paris";
    locale = "en_US.UTF-8";
    keyboard = "us";
  };

  # Theme and appearance
  theme = let
    wallpaperPath = ./home/wallpapers/original/teto.jpg;
    profilePicturePath = ./home/pfp.png;
  in {
    inherit wallpaperPath;
    wallpaperString = toString wallpaperPath;
    polarity = "dark";

    profilePictureString = toString profilePicturePath;
  };
}
