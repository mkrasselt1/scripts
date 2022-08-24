<?php
error_reporting(E_ALL);

//DB_ACCESS
$db_host="DBHOST";
$db_name="DBNAME";
$db_user="DBUSER";
$db_pass="DBPASSWD";

//Remote Backup Location
$s = [
    'baseUri' => 'https://webdavstorage.host',
    'userName' => 'webdavuser',
    'password' => 'webdavpasswd',
];



//No Change below this point 

$datetime = date("Y-m-d-H:i:s");

$sql_file="./db_backup_".$datetime.".sql";
$nextcloud_file="./files_backup_".$datetime.".tar.gz";

$files[]=$sql_file;
$files[]=$nextcloud_file;

//MYSQL Backup
shell_exec("mysqldump ".$db_name." --add-drop-table -h ".$db_host." -u ".$db_user." -p".$db_pass." > ".$sql_file);
//Nextcloud Folder
shell_exec("tar -cpzf ".$nextcloud_file." -C ./files/ .");

//Upload Backup
foreach($files as $file){
	shell_exec("curl --user '".$s["userName"].":".$s["password"]."' -T '".$file."' '".$s["baseUri"]."/'");
	shell_exec("rm $file");
}

echo "Backup Successfull";
?>
