# Run all fio tests in one given directory
dir=$1
result_dir=$2 # result directory name
cd $dir
# mkdir $result_dir
# get file names from $dir
for file in $(find . -name "*.fio"); do 
    # run fio
    fio $file > $result_dir/$file-results
    # sudo fio $file > $result_dir/$file-results
    echo "Saved test results to "$result_dir/$file-results
done
