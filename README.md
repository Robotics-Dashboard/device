# Robotics Dashboard Device

![device](device.png)


### Build

```bash
docker compose build
```

### About

---

The device code that runs on remote devices. 

This module: 

- Self validates the configuration
- If the configuration is incomplete, it will fetch it
- Configures its wireguard VPN
- Sends a heartbeat to the server
