{ ... }: {
  services.koito = {
    enable = true;
    environment = {
      KOITO_BIND_ADDR = "127.0.0.1";
      KOITO_LISTEN_PORT = 8019;
    };
  };
}
