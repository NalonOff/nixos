{
  # User settings
  user = {
    username = "nalon";
    fullName = "Nalon";
    email = "nalonoff@gmail.com";
    userCountry = "FRANCE"; # Upper case only
    userCity = "Tarbes";

    profilePicture = "./home/nalon.png";
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
    wallpaperPath = ./home/wallpapers/original/kimono.png;
  in {
    inherit wallpaperPath;
    wallpaperString = toString wallpaperPath;
    polarity = "dark";
  };
}
