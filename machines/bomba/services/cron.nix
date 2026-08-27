{ ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 * * * root backup-cli"
    ];
  };
}
