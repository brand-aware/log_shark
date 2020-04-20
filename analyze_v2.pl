#author - mike802
#version - 1.0, 2/19/2013

use IO::Handle;

#TODO:
#$filename = $_1;
#$outfile = $_2;
#$outfile_approved = $_3;

$filename = "C:\Users\mike802\My Code\perl\log_shark\data\capture1.txt";
$outfile = "C:\Users\mike802\My Code\perl\log_shark\output.txt";
$outfile_approved = "C:\Users\mike802\My Code\perl\log_shark\output_approved.txt";

$fh_input = new IO::Handle;
$fh_input -> open($filename);

if($fh_input -> opened){
	@lines = $fh_input -> getlines;
}

%ip_list;

foreach $new_input (@lines){
	@match_list = ($new_input =~ /[^0-9]+\.[^0-9]+\.[^0-9]+\.[^0-9]+/g);
	
	foreach $match (@match_list){
		if(exists $ip_list{$match}){

		}else {
			$ip_list{$match} = $match;
		}
	}
}

%ip_list_approved;
%ip_list_output;

$fh_output = new IO::Handle;
$fh_output->open($outfile);

$fh_output_approved = new IO::Handle;
$fh_output_approved->open($outfile_approved);

if($fh_output->opened){
	@data_approved = $fh_output_approved->getlines;
}

foreach $input_aproved (@data_approved){
	if(exists $ip_list_approved{$input_approved}){
	
	} else {
		$ip_list_approved{$input_approved} = $input_approved;
	}
}

if($fh_output->opened){
	@data = $fh_output->getlines;	
}

foreach $input (@data) {
	if(exists $ip_list_approved{$input}){
		

	} else {
		print "$input\n";
		$ip_list_output{$input} = $input;
	}
}

@new_list = keys(ip_list);
foreach $new_key (@new_list){
	if(exists $ip_list_approved{$new_key}){
		
	} else {
		if(exists $ip_list_output{$new_key}){
				
		} else {
			print "NEW ENTRY: ";
			print "$input\n";
			ip_list_output{$new_key} = $new_key;
		}
	}
}

$offset = 0;
@list = keys(%ip_list_output);
foreach $key (@list){
	$length = length ($key);
	$fh_output->write($key, $length, $offset);
	$offset = offset + $length;
}