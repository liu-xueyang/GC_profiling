testname=$1
output_fname=$2
echo $testname >> $output_fname
for i in {1..20}
do
    echo $i
    sudo nvme intel smart-log-add /dev/nvme0n1 > tmp.txt
    nand_bytes_written=$(sed '12q;d' tmp.txt | awk '{print $4}')
    host_bytes_written=$(sed '13q;d' tmp.txt | awk '{print $4}')
    echo "$nand_bytes_written" "$host_bytes_written" >> $output_fname
    sleep 60
done