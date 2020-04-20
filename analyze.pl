#author - mike802
#version - 1.0, 2/19/2013

use IO::Handle;

$filename = "C:\\Users\\mike802\\My Code\\perl\\log_shark\\data\\capture1.txt";
$outfile = "C:\\Users\\mike802\\My Code\\perl\\log_shark\\output.txt";

$fh_input = new IO::Handle;
$fh_input->open($filename);
#$fh_input->fdopen($fh_input, "r+");

if($fh_output -> opened){
	@lines = $fh_input -> getlines;
}
%ip_list;

foreach $input (@lines){
	@match_list = ($input =~ /[^0-9]+\.[^0-9]+\.[^0-9]+\.[^0-9]+/g);
	
	foreach $match (@match_list){
		if(exists $ip_list{$match}){

		}else {
			print "match: $match\n";
			$ip_list{$match} = $match;
		}
	}
}

$fh_output = new IO::Handle;
$fh_output -> open($outfile);

if($fh_output -> opened){
	@data = $fh_output -> getlines;
}

foreach $input2 (@data) {
	if(exists $ip_list{$input2}){

	}else{
		$ip_list{$input2} = $input2;
	}
}

$offset = 0;
@list = keys(%ip_list);
foreach $key (@list){
	$length = length($key);
	print "writing to file: $key\n";
	$fh_output -> write($key, $length, $offset);
	$offset = $offset + $length;
}