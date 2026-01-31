{ config, ... }:
{
	hardware = {
		graphics.enable = true;
		nvidia = {
			modesetting.enable = true;	
			package = config.boot.kernelPackages.nvidiaPackages.beta;
			open = true;
			prime = {
				offload = {
					enable = true;
					enableOffloadCmd = true;
				};

				intelBusId = "PCI:0:2:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};
	};
}
