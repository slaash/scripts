#!/usr/bin/perl -IZ:\msext\lib

use strict;
use warnings;
use XML::Smart;
use XML::DOM;
use POSIX qw(strftime);
use Encode qw/encode decode/;

######################### USER VARIABLES #####################
my $basedir="/HOME/ccm_wet/local/scripts/bmwext";
####################### END USER VARIABLES ###################

#get_XML_data(<XML file>)
#should return an array of hashes with information from ISSUES field, one hash for every ISSUE
sub get_XML_issues
{
my $file=$_[0];
my $parser = new XML::DOM::Parser;
my $doc = $parser->parsefile($file);
my $team_id;
my %teams;
my $tmp_assign_ecu;

my @company_level_0 = $doc->getElementsByTagName('COMPANIES');
foreach (@company_level_0){
	my @company_level_1 = $_->getChildNodes;
	foreach (@company_level_1){
		my @company_level_2 = $_->getChildNodes;
		foreach (@company_level_2){
			my @company_level_3 = $_->getChildNodes;
			foreach (@company_level_3){
				if ($_->getNodeName eq "TEAM-MEMBER"){
					$team_id = $_->getAttribute("ID");
				}
				my @company_level_4 = $_->getChildNodes;
				foreach (@company_level_4){
					if ($_->getNodeName eq "LONG-NAME"){
						if ($_->getFirstChild()){
							$teams{$team_id}=$_->getFirstChild()->getData();
						}
					}
				}
			}
		}
	}
}

my $ack_date;
my @admin_data_level_0=$doc->getElementsByTagName('ADMIN-DATA');
	foreach (@admin_data_level_0){
		my @doc_revs_level_1=$_->getChildNodes;
		foreach (@doc_revs_level_1){
			my @doc_rev_level_2=$_->getChildNodes;
			foreach (@doc_rev_level_2){
				my @doc_rev_level_3=$_->getChildNodes;
				foreach (@doc_rev_level_3){
					if ($_->getNodeName eq "DATE"){
						if ($_->getFirstChild()){
							$ack_date=$_->getFirstChild()->getData();
#							print "ACK Date: $ack_date\n";
						}
					}
				}
			}
		}
	}

my @level0 = $doc->getElementsByTagName('ISSUES');
my @vect_final;
foreach (@level0){
	my @level1=$_->getChildNodes;
	foreach (@level1){
		if ($_->getNodeName eq "ISSUE"){
			my @level2=$_->getChildNodes;
			my %issue=(key => "",
					feedback => "",
					attachments => "",
					planned_closing_version => "",
					resolution => "",
					committed_date => "",
					closed_in_version => "",
					status => "");
			foreach (@level2){
				if ($_->getNodeName eq "COMPANY-ISSUE-INFOS"){
					my @level3=$_->getChildNodes;
					foreach (@level3){
						if (($_->getNodeName eq "COMPANY-ISSUE-INFO") and ($_->getAttribute("SI") eq "database id" )){
							my @level4=$_->getChildNodes;
							my $control_flag = 0;
							foreach (@level4){
								if (($_->getNodeName eq "COMPANY-REF") and ($_->getAttribute("ID-REF") eq "bmw" )){
									$control_flag = 1;
								}

								if (($_->getNodeName eq "ISSUE-ID") and ($_->getAttribute("SI") eq "JIRA" )){
									if (($control_flag == 1) and ($_->getFirstChild())){
										print $issue{"key"}=$_->getFirstChild()->getData();
										print "\n";
										$control_flag=0;
									}
								}
							}
						}
					}
				}
				

				if ($_->getNodeName eq "ISSUE-SOLUTIONS"){
					my @level3=$_->getChildNodes;
					foreach (@level3){
						if ($_->getNodeName eq "ISSUE-SOLUTION"){
							my @level4=$_->getChildNodes;
							foreach (@level4){
								if ($_->getNodeName eq "ISSUE-SOLUTION-DESC"){
									my @level5=$_->getChildNodes;
									foreach (@level5){
										if ($_->getNodeName eq "P" and $_->getFirstChild()){
											my $SI=$_->getAttribute("SI");
											my $value=$_->getFirstChild()->getData();
											if ($SI eq "feedback"){
												print $issue{"feedback"}=$value;
												print "\n";
											}
											if ($SI eq "committed-date"){
												print $issue{"committed_date"}=$value;
												print "\n";
											}
											if ($SI eq "planned-closing-version"){
												print $issue{"planned_closing_version"}=$value;
												print "\n";
											}
											if ($SI eq "resolution"){
												if ($value){
													print $issue{"resolution"}=$value;
													print "\n";
												}
											}
											if ($SI eq "closed-in-version"){
												print $issue{"closed_in_version"}=$value;
												print "\n";
											}
											if ($SI eq "status"){
												print $issue{"resolution"}=$value;
												print "\n";
											}
											if ($SI eq "attachment"){
												my @level6=$_->getChildNodes;
												foreach (@level6){
													if ($_->getNodeName eq "XFILE"){
														my @level7=$_->getChildNodes;
														my $att_name="no name";
														my $att_file="no_file";
														foreach (@level7){
															if ($_->getNodeName=~/^LONG-NAME/){
																$att_name=$_->getFirstChild()->getData();
															}
															if ($_->getNodeName=~/^SHORT-NAME/){
																$att_file=$_->getFirstChild()->getData();
															}			
														}
														print $issue{"attachments"}.="$att_name:$att_file,";
														print "\n";
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			$issue{"ack_date"}=$ack_date;	
			push (@vect_final,{%issue});
			undef %issue;
		}
	}
}
return @vect_final;
}

#store_XML_data(<array of hashes>,<output file>)
#should put the content of the array in the output XML file
#new version uses XML::Smart
sub store_XML_data
{
my ($output_file,@input_data)=@_;

my @team1=("summerauer thomas", "team1");
my @team2=("janine jaeckel", "team2");
my @teams=([@team1],[@team2]);

my $crt=1;
my $XML = XML::Smart->new(q`<?xml version="1.0" encoding="UTF-8" ?><MSR-ISSUE xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="msr-issue_2_1_0_rc4.xsd"></MSR-ISSUE>`) ;
$XML = $XML->cut_root() ;
$XML->{'SHORT-NAME'}->content("bmw");
$XML->{'CATEGORY'}->content("problem");
$XML->{'COMPANIES'}->set_tag;
$XML->{'COMPANIES'}{'COMPANY'}[0]={ID=>'bmw',ROLE=>'manufacturer'};
$XML->{'COMPANIES'}{'COMPANY'}[0]{'LONG-NAME'}->content("Bayrische Motorenwerke");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'SHORT-NAME'}->content("bmw");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}->set_tag;
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]={ID=>"team1"};
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'LONG-NAME'}->content("summerauer thomas");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'SHORT-NAME'}->content("summerauer thomas");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'DEPARTMENT'}->content("");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'PHONE'}->content("");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'EMAIL'}->content("thomas.summerauer\@bmw.de");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]={ID=>"team2"};
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'LONG-NAME'}->content("janine jaeckel");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'SHORT-NAME'}->content("janine jaeckel");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'DEPARTMENT'}->content("");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'PHONE'}->content("");
$XML->{'COMPANIES'}{'COMPANY'}[0]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'EMAIL'}->content("janine.jaeckel\@partner.bmw.de");
$XML->{'COMPANIES'}{'COMPANY'}[1]={ID=>'Conti',ROLE=>'supplier'};
$XML->{'COMPANIES'}{'COMPANY'}[1]{'LONG-NAME'}->content("Conti");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'SHORT-NAME'}->content("Conti");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]={ID=>"team1"};
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'LONG-NAME'}->content("Andreas Voelkel");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'SHORT-NAME'}->content("Andreas Voelkel");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'DEPARTMENT'}->content("I MM EU2 R PM");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'PHONE'}->content("+49 (6441) 370-8668");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[0]{'EMAIL'}->content("Andreas.Voelkel\@continental-corporation.com");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]={ID=>"team2"};
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'LONG-NAME'}->content("Joerg Articus");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'SHORT-NAME'}->content("Joerg Articus");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'DEPARTMENT'}->content("I MM EU2 R PM");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'PHONE'}->content("+49 (6441) 370-879");
$XML->{'COMPANIES'}{'COMPANY'}[1]{'TEAM-MEMBERS'}{'TEAM-MEMBER'}[1]{'EMAIL'}->content("Joerg.Articus\@continental-corporation.com");
$XML->{'ADMIN-DATA'}->set_tag;
$XML->{'ADMIN-DATA'}{'DOC-REVISIONS'}{'DOC-REVISION'}->set_tag;
$XML->{'ADMIN-DATA'}{'DOC-REVISIONS'}{'DOC-REVISION'}{'TEAM-MEMBER-REF'}={SI=>'transfer','ID-REF'=>'WHAT TEAM WILL BE LISTED HERE?'};
my $now=strftime("%Y-%m-%dT%H:%M:%S", localtime);
#here we store the current export time
#we should get confirmation from next ack files from BMW
#open ACKS_DB,">>","$basedir/acks_db.txt";
#print ACKS_DB "$now,0\n";
#close ACKS_DB;
$XML->{'ADMIN-DATA'}{'DOC-REVISIONS'}{'DOC-REVISION'}{'DATE'}->content("$now");
for (my $i = 0; $i <= $#input_data; $i++){
	my $index = $i + 1;
	$XML->{ISSUES}{ISSUE}[$i] = {ID=>"ISSUE-$index"};
	$XML->{ISSUES}{ISSUE}[$i]{"LONG-NAME"}->content("$input_data[$i]->{problem_synopsis}");
	$XML->{ISSUES}{ISSUE}[$i]{"SHORT-NAME"}->content("$input_data[$i]->{crid}");
#	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}->set_binary(0);
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[0]={SI => "description"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[0]->content("TicketNr im QC: $input_data[$i]->{read_only_string}\n$input_data[$i]->{problem_description}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[1]={SI => "category-1"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[1]->content("$input_data[$i]->{problem_category_1}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[2]={SI => "category-2"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[2]->content("$input_data[$i]->{problem_category_2}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[3]={SI => "category-3"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[3]->content("$input_data[$i]->{problem_category_3}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[4]={SI => "error-occurrence"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[4]->content("$input_data[$i]->{error_occurrence}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[5]={SI => "occurrence-milestone"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[5]->content("$input_data[$i]->{occurence_milestone}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[6]={SI => "recorded-date"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[6]->content("$input_data[$i]->{recorded_date}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[7]={SI => "bmw-comments"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[7]->content("$input_data[$i]->{bmw_comments}");
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[8]={SI => "supplierTracking"};
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[9]={SI => "attachment"};
	my @attaches;
	my $attachment;
	if ($input_data[$i]->{attachments}){
		my @attaches=split(/\|/,$input_data[$i]->{attachments});
#		my $crt=1;
		for (my $k = 0; $k <= $#attaches; $k++){
			my @lm=split(/:/,$attaches[$k]);
			$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[9]{"XFILE"}[$k] = {ID => "ATTACH-$crt"};
			$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[9]{"XFILE"}[$k]{"LONG-NAME-1"}->content("$lm[0]");
			$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[9]{"XFILE"}[$k]{"SHORT-NAME"}->content("$lm[1]");
			$crt++;
		}
	}
	else {
		print "No new attachments for export\n";
	}
	$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[10] = {SI => "attachmentlist"};
	if ($input_data[$i]->{attachmentlist}){
		@attaches=split(/\|/,$input_data[$i]->{attachmentlist});
		for (my $j = 0; $j <= $#attaches; $j++){
			$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[10]{TT}[$j] = {SI => "attachment", TYPE => "OTHER"};
			$XML->{ISSUES}{ISSUE}[$i]{"ISSUE-DESC"}{"P"}[10]{TT}[$j]->content("$attaches[$j]");
		}
	}
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[0]={SI=>'database id'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[0]{'COMPANY-REF'}={'ID-REF'=>'bmw'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[0]{'COMPANY-REF'}->content("bmw");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[0]{'ISSUE-ID'}={'SI'=>'JIRA'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[0]{'ISSUE-ID'}->content("bmw");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[0]{'ISSUE-ID'}->content("$input_data[$i]->{jira_id}"); # Rectificare valoare? -> DA: JIRA ID
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[1]={SI=>'role'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[1]{'COMPANY-REF'}={'ID-REF'=>'bmw'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[1]{'COMPANY-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[1]{'TEAM-MEMBER-REF'}={'ID-REF'=>'team1','SI'=>'finder'}; # Rectificare valoare? Hard coded?
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[1]{'TEAM-MEMBER-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[2]={SI=>'role'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[2]{'COMPANY-REF'}={'ID-REF'=>'bmw'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[2]{'COMPANY-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[2]{'TEAM-MEMBER-REF'}={'ID-REF'=>'team1','SI'=>'recorder'}; # Rectificare valoare? Hard coded?
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[2]{'TEAM-MEMBER-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[3]={SI=>'role'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[3]{'COMPANY-REF'}={'ID-REF'=>'bmw'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[3]{'COMPANY-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[3]{'TEAM-MEMBER-REF'}={'ID-REF'=>'team1','SI'=>'analysis'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[3]{'TEAM-MEMBER-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[4]={SI=>'role'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[4]{'COMPANY-REF'}={'ID-REF'=>'bmw'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[4]{'COMPANY-REF'}->content("team1");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[4]{'TEAM-MEMBER-REF'}={'ID-REF'=>'team1','SI'=>'responsible'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[4]{'TEAM-MEMBER-REF'}->content("team1");
	my $fStr = $input_data[$i]->{crid};
#	$fStr =~ s/_/zzz/;
#	$fStr =~ s/#/xxx/;
	$fStr =~ s/#/_/;
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[5]={SI=>'database id'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[5]{'COMPANY-REF'}={'ID-REF'=>'Conti'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[5]{'COMPANY-REF'}->content("Conti");
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[5]{'ISSUE-ID'}={'SI'=>'Conti'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[5]{'ISSUE-ID'}->content($fStr); # Rectificare valoare? -> NU: Valoare corecta.
	
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[6]={SI=>'role'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[6]{'COMPANY-REF'}={'ID-REF'=>'Conti'};
	$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[6]{'COMPANY-REF'}->content("Conti");
	foreach my $team_member (@teams) { # Responsible at Conti - Rectificare valoare! Hard coded.
		if ($input_data[$i]->{responsible} eq $team_member->[0]){
			$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[6]{'TEAM-MEMBER-REF'}={'ID-REF'=>"$team_member->[1]", 'SI'=>"responsible"};
			$XML->{ISSUES}{ISSUE}[$i]{'COMPANY-ISSUE-INFOS'}{'COMPANY-ISSUE-INFO'}[6]{'TEAM-MEMBER-REF'}->content("$team_member->[1]");
		}
	}
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'ISSUE-CURRENT-STATE'}{'DATE'}={'SI'=>'last update'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'ISSUE-CURRENT-STATE'}{'DATE'}->content("1970-01-01T00:00:00");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'ISSUE-CURRENT-STATE'}{'ISSUE-STATE'}={'SI'=>'status-bmw'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'ISSUE-CURRENT-STATE'}{'ISSUE-STATE'}->content("$input_data[$i]->{crstatus}");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'ISSUE-SEVERITY'}={'SI'=>''};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'ISSUE-SEVERITY'}->content("$input_data[$i]->{severity}");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'DELIVERY-DATE'}->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-PLANNING-INFOS'}{'DELIVERY-MILESTONE'}->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'PROJECT-IDS'}->set_tag;
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'PROJECT-IDS'}{'PROJECT-ID'}={'SI'=>'model involved'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'PROJECT-IDS'}{'PROJECT-ID'}->content($input_data[$i]->{lead_model});
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]->set_tag;
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SHORT-LABEL'}->content($input_data[$i]->{assigned_ecu});
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'CATEGORY'}->content("assigned ecu");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SDGS'}{'SDG'}[0]={'GID'=>'versioning'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SDGS'}{'SDG'}[0]{SD}[0]={'GID'=>'hw version'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SDGS'}{'SDG'}[0]{SD}[1]={'GID'=>'sw version'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SDGS'}{'SDG'}[0]{SD}[1]->content("$input_data[$i]->{ecu_sw}"); # Rectificare valoare? E ptr.assigned ecu? sau affected ecu?
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SDGS'}{'SDG'}[1]={'GID'=>'variants'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[0]{'SDGS'}{'SDG'}[1]{SD}={'GID'=>'ECU variant'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]->set_tag;
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]{'SHORT-LABEL'}->set_tag;
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]{'CATEGORY'}->content("affected ecu");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]{'SDGS'}{'SDG'}[0]={'GID'=>'versioning'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]{'SDGS'}{'SDG'}[0]{SD}[0]={'GID'=>'hw version'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]{'SDGS'}{'SDG'}[0]{SD}[1]={'GID'=>'sw version'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-ENVIRONMENT'}{'ENGINEERING-OBJECTS'}{'ENGINEERING-OBJECT'}[1]{'SDGS'}{'SDG'}[0]{SD}[1]->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[0]={'SI'=>'feedback'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[0]->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[1]={'SI'=>'committed-date'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[1]->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[2]={'SI'=>'detection-date'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[2]->content("$input_data[$i]->{detection_date}");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[3]={'SI'=>'planned-closing-version'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[3]->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[4]={'SI'=>'closed-in-version'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[4]->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[5]={'SI'=>'status'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[5]->content("");
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[6]={'SI'=>'attachment'};
	$XML->{ISSUES}{ISSUE}[$i]{'ISSUE-SOLUTIONS'}{'ISSUE-SOLUTION'}{'ISSUE-SOLUTION-DESC'}{'P'}[6]->content("");
}
my $data = $XML->data();
$XML->save("$output_file", nometagen=>1);	
}


#store(ack_XML_data(<output file>,<ackDate>)
sub store_ack_XML_data
#first parameter should be ackDate for the file we are acknowledging
{
        my $output_file=$_[0];
	my $ack_date=$_[1];

        my $elem;
        my $elem1;
        my $elem2;
        my $elem3;
        my $elem4;
        my $elem5;
        my $text;
        my $text1;
        my $text2;
        my $text3;
        my $text4;
        my $text5;
        my $crt=1;#this is the att-n counter, so we increment for all issues

        my $doc = XML::DOM::Document->new;
        my $xml_pi = $doc->createXMLDecl ("1.0", "UTF-8");

        my $root = $doc->createElement("ACKNOWLEDGMENTS");
        $root->setAttribute("xmlns","");
        $root->setAttribute("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance");
        $root->setAttribute("xsi:noNamespaceSchemaLocation","acknowledgments_1_0_0.xsd");

        $elem=$doc->createElement("SUPPLIER");
        $text=$doc->createTextNode("Conti");
        $elem->appendChild($text);
        $root->appendChild($elem);

	open PRS,"<","$basedir/Conti_imported_PRs.txt";
#	open PRS,"<","../Conti_imported_PRs.txt";
	while (<PRS>){
		chomp $_;
		my @data=split(/,/,$_);
		my $conti_id=$data[0];
		$conti_id=~s/#/_/;
		my $bmw_id=$data[1];
		my $import_date=$data[2];
		$import_date=~s/_/-/g;
		$ack_date=~s/_/-/g;
#		my $ack_date=strftime "%Y_%m_%dT%H-%M-%S", localtime;
		$elem=$doc->createElement("ACKNOWLEDGMENT");
                        $elem1=$doc->createElement("ticketNoBMW");
                        $text1=$doc->createTextNode($bmw_id);
                        $elem1->appendChild($text1);
                $elem->appendChild($elem1);
			$elem1=$doc->createElement("ticketNoSupplier");
			$text1=$doc->createTextNode($conti_id);
			$elem1->appendChild($text1);
		$elem->appendChild($elem1);
			$elem1=$doc->createElement("importDate");
                        $text1=$doc->createTextNode($import_date);
                        $elem1->appendChild($text1);
                $elem->appendChild($elem1);
                        $elem1=$doc->createElement("ackDate");
                        $text1=$doc->createTextNode($ack_date);
                        $elem1->appendChild($text1);
		$elem->appendChild($elem1);
	
		$root->appendChild($elem);
	}
	close PRS;

#	$root->appendChild($elem);

        open OUT, ">:utf8", $output_file;
        print OUT $xml_pi->toString.$root->toString;
        close OUT;
}

#get_ack_XML_data(<ack_file.xml>)
#updates the bmw_ids.txt file with BMW IDs and acks_db.txt file with confirmation for Conti's export times (ADMIN-DATA/DATE vs. ackDate)
sub get_ack_XML_data {
	my $file = $_[0];

	my @array_hash;
	my @array_file;
	my %ids;
        my %acks_db;

        open ACKS_DB,"<","$basedir/acks_db.txt";
        while (<ACKS_DB>){
		if ($_ !~ /^#/){
                	chomp $_;
                	my @line=split(/,/,$_);
                	$acks_db{$line[0]}=$line[1];
		}
        }
        close ACKS_DB;

	my $XML  = XML::Smart->new($file);
	my @acks = @{ $XML->{'ACKNOWLEDGMENTS'}{'ACKNOWLEDGMENT'} };
	foreach my $ack_i (@acks) {
		my $conti_no = $ack_i->{ticketNoSupplier};
		if ($conti_no=~/(.+)_(\d+)/){
			$conti_no="$1#$2";
		}
		my $bmw_no = $ack_i->{ticketNoBMW};
		print "\t$conti_no => $bmw_no\n";
		$ids{"$conti_no"} = $bmw_no;
        
	        my $tmpackDate=$ack_i->{ackDate};
                if (exists($acks_db{$tmpackDate})){
                        if (!$acks_db{$tmpackDate} or $acks_db{$tmpackDate}==0){
                                print "\tACK Date $tmpackDate confirmed\n";
                                $acks_db{$tmpackDate}=1;
                        }
                        else{
                                print "\t$tmpackDate already confirmed\n";
                        }
                }
                else{
                        print "\tGot confirmation for inexistent export date ($tmpackDate)!!!\n";
			$acks_db{$tmpackDate}=1;
                }
	}

        open ACKS_DB,">","$basedir/acks_db.txt";
        foreach (sort(keys %acks_db)){
                print ACKS_DB $_.",".$acks_db{$_}."\n";
        }
        close ACKS_DB;

	while ( my ( $key, $value ) = each(%ids) ) {
		push( @array_hash, "$key,$value" );
	}

	open( DAT, "<", "$basedir/bmw_ids.txt" ) || die("Cannot open file");
	foreach (<DAT>) {
		chomp($_);
		push( @array_file, $_ );
	}
	close(DAT);

	open( DAT, ">>", "$basedir/bmw_ids.txt" ) || die("Cannot open file");
	my %array_file = map { $_, 1 } @array_file;
	my @difference = grep { !$array_file{$_} } @array_hash;
	foreach (@difference) {
		print DAT "$_\n";
	}
	close(DAT);
}

print "xmlfunc ran successfully\n";
