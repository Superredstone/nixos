{ ... }:
{
  services.paperless = {
    enable = true;
    port = 8018;
    settings = {
      PAPERLESS_URL = "https://paperless.patrickcanal.it";
      PAPERLESS_OCR_LANGUAGE = "ita";
    };
  };
}
