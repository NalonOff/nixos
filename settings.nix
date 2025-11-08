{
  # User settings
  user = {
    username = "nalon";
    fullName = "Nalon";
    email = "nalonoff@gmail.com";
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
    wallpaperPath = ./home/wallpapers/original/hatsune-miku-samurai-katana-sword-anime-girl-4k-wallpaper-uhdpaper.com-2065b.jpg;
  in {
    inherit wallpaperPath;
    wallpaperString = toString wallpaperPath;
    polarity = "dark";

    profilePicture = "./home/pfp.png";
  };
}
