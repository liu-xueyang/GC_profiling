# unmount the SSD
sudo umount /dev/nvme0n1
# format the SSD
sudo nvme format -s 1 /dev/nvme0n1
sleep 30
# reprogram the file system
sudo mkfs.ext4 /dev/nvme0n1
# mount the SSD
sudo mount /dev/nvme0n1 /mnt/SmartSSD/
lsblk
df /mnt/SmartSSD/