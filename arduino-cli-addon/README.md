# OTA Arduino Compiler
This Home Assistant add-on allows you to compile Arduino code and upload it to Arduino devices via TFTP.

## Configuration

In the add-on configuration, provide the following:

- **sketch_file**: Path to the Arduino sketch file.
- **target_ip**: IP address of the Arduino device.
- **board_type**: Arduino board type (e.g., `arduino:avr:uno`).

## Example Configuration

```yaml
sketch_file: "/config/arduino_sketches/my_sketch.ino"
target_ip: "192.168.1.100"
board_type: "arduino:avr:uno"


---

### 9. **Build and Install the Add-on**

Once you’ve set up your GitHub repository with the above structure:

1. **Add your GitHub repository** in Home Assistant:
   - Go to **Settings** > **Add-ons** > **Add-on Store**.
   - Click the three dots in the upper right corner and select **Repositories**.
   - Add the link to your GitHub repository, e.g.,:
     ```
     https://github.com/<your-username>/ota-arduino-hacs
     ```

2. **Install the Add-on**:
   - Your add-on should now appear in the Add-on Store.
   - Install it and configure it using the example provided in **README.md**.

3. **Run the Add-on**:
   - Once the add-on is installed, you can start it.
   - It will compile the provided **Arduino sketch** and upload it to the specified IP address via **TFTP**.

---

### Summary

This approach closely mirrors how **ESPHome** is structured, but it's tailored to **compile and upload Arduino code via TFTP**. We created:
- A **structured repository** with essential scripts.
- A **Dockerfile** that sets up the environment.
- Scripts to handle **Arduino code compilation** and **firmware uploading** via TFTP.

Let me know if you need further assistance or modifications!