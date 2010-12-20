#!/usr/bin/perl
#-----------------------------------------------------------------------------
# Import Part
#-----------------------------------------------------------------------------

# Standard Packages

use Tk;							# Needed for the graphical toolkit
use Tk::Dialog;					# Needed for popup dialog boxes
#use Tk::TList; 
#use threads;					#use separate threads to execute a tool version
#use threads::shared;
#my $thrmax : shared = 20;
#-----------------------------------------------------------------------------
# LOCAL DEFINITIONS
#-----------------------------------------------------------------------------

### Private Constants
# Constants for $exit_state
my $continue	= $SVar::continue;
my $exit		= $SVar::exit;
my $problem		= $SVar::problem;

### Private Variables
my $exit_state = $continue;

# gui controls (labels are temporary resources)
my $w_main = undef;                             # main window
my $const_btn_width = 12; 

### Global variables
my $configfile=undef;
my @Projects=undef;#takes the projects name
my @Roles=undef;#saves the roles
my @tools=undef;
my $mbar=undef;
my $menu_buton=undef;


#################################################################################
# PURPOSE:              Generate window with all controls
#
# CALL:                 InitWindow()
#################################################################################

sub InitWindow
{
	# Generate a new main window
	$w_main = MainWindow->new();
	$w_main->maxsize(650,320);                                   # Limits the maximum dimensions of the main window
	$w_main->minsize(650,320);                                   # Limits the minimum dimensions of the main window
	# Set title for main window
	$w_main->title('****Umbrella GUI****');
	
	#create main menu
	$mbar = $w_main -> Menu();
	$w_main -> configure(-menu => $mbar);
	my $file = $mbar -> cascade(-label=>"File", -underline=>0, -tearoff => 0);
	my $projects=$mbar -> cascade(-label=>"Projects", -underline=>0, -tearoff => 0);
	my $help=$mbar -> cascade(-label=>"Help", -underline=>0, -tearoff => 0);
	my $lbox_location=undef;
	my $lbox_version=undef;
	$file -> command(-label => "Clear", -underline=>0, -command=>sub { if ($lbox_location) {$lbox_location->delete(0, 'end')};
																	   if ($lbox_version) {$lbox_version->delete(0, 'end')};
																	   $w_main->Button(      -text           => "",
																		-width          => '30',
																		-state		  =>'disabled'	
																		)->place(-x => 400, -y => 30);
																	   } );
	$file -> command(-label => "Exit", -underline=>0, -command=>sub {exit} );
	my $project=undef;
	my $role=undef;
	my $role_btn=undef;
	my $tool=undef;
	my @versions=undef;

	foreach $project(@Projects)
	{
		my $prj=$projects->cascade(-label => $project, -underline=>0, -command=>sub { } );
		#my $role=undef;
		foreach $role(@Roles)
		{
			#$role_btn = $prj -> cascade(-label =>$role, -underline => 0, -command=>sub 
			$role_btn = $prj -> cascade(-label =>$role, -underline => 0, -command=>sub{});
																	
																			
			@tools=ParseConfigfile($configfile,$project,$role); 
			#print @tools;
			#my $tool=undef;
			foreach $tool(@tools)
			{
				my $line=undef;
				my @values=undef;
				my @sub_menus=undef;
				my $sub_tool=undef;
				my @tool_path=undef;
				my @local_array=undef;
				my @paths=undef;
				my @tool_path=undef;
				
				chomp($tool);
				print $tool;
				@values = split('@@@', $tool);
				#print "values in create menu";
				print @values[0]."\n";
				my $string=@values[0];
				if ($string ne "")
				{
					my $menu_buton1 =$role_btn -> command(-label=>$string, -underline=>0, -command=>sub 
					{ 
						my $str=$project."~~~".$role."~~~".$string;
						#my $label=$w_main->Label(-textvariable => \$str)->pack();
						$w_main->Button(      -text           => $str,
											  -width          => '30',
											  -state		  =>'disabled'	
											)->place(-x => 400, -y => 30);
						@versions=split(';',@values[1] );
						#@paths=undef;
						my @tool_vers=undef;
						my @tool_location=undef;
						foreach $sub_tool(@versions)
						{
							@tool_path=split('=',$sub_tool);
							push (@paths,@tool_path[1]);
							@local_array=split('~~~',@tool_path[0]);
							
							print "\nversion:".@local_array[0]."\n";
							print "tool_path0:".@local_array[1]."\n";
							if (@local_array[0]ne"")
							{
								push (@tool_vers,@local_array[0]);
							}
							if (@local_array[1]ne"")
							{
								push (@tool_location,@local_array[1]);
							}
							
						}
						
						
						#check if tools have a single version- ex:DOORS/Sitemppo 
						#if (@local_array[1]eq""){system(@paths[0]);}
						print "tool_vers_no=".$#tool_vers;
						if ($#tool_vers>1)
						{
						
							my %saw=undef;;
							my @out = grep(!$saw{$_}++, @tool_vers);
							#my $lbox_version=undef;
							$lbox_version = $w_main->Listbox(-exportselection => 0)->place(-x => 30, -y => 30);#->pack();
							$lbox_version->insert('end', @out );
							#my $lbox_location=undef;
							if ($lbox_location) {$lbox_location->delete(0, 'end')};
							$lbox_location = $w_main->Listbox(-exportselection => 0);
							$lbox_version->bind('<<ListboxSelect>>'=> sub 
										{
											#my $thread1=threads->new(sub 
											#						{
																		#event of the version selection
																		#parse the hash and print in listbox 2 all the hash[version=curreent selection][element of new listbox]
																		my @printed_locations=undef;
																		$lbox_location->insert('end',@printed_locations);
																		my $vers=undef;
																		my $current_sel=@out[$lbox_version->curselection];
																		print "\ncurrent selection".$current_sel."test\n";
																		my $index=-1;
																		my $selected_index=undef;
																		if ($current_sel ne "")
																		{
																			foreach $vers(@tool_vers)
																			{
																				$index=$index+1;
																				if ($current_sel eq $vers)
																				{
																				
																					
																					push(@printed_locations,@tool_location[$index]);#[Indexof($vers,@tool_vers)]);
																					print "index=".$index."\n";
																					#$selected_index=$index;
																				}
																			}
																		}
																		$lbox_location = $w_main->Listbox(-exportselection => 0)->place(-x => 210, -y => 30);#->pack();
																		$lbox_location->insert('end',@printed_locations);
																		my $btn_show_tools = $w_main->Button(      -text           => "Go",
																													-width          => $const_btn_width,
																													-command        => sub 
																													{ 
																															if (($lbox_location->curselection()=="")||($lbox_version->curselection()==""))
																															{
																																my $message     = $w_main->messageBox(
																																-icon         => 'warning',
																																-message     => 'Please select the version and location first!',
																																-title         => 'Important selection',
																																-type         => 'Ok',);
																															}
																															else
																															{
																																my $current_sel_version=@out[$lbox_version->curselection];
																																my $current_sel_location=@printed_locations[$lbox_location->curselection];
																																print "current_sel_version ".$current_sel_version."\n"; 
																																print "current_sel_location ".$current_sel_location."\n"; 
																																my $vers_location=undef;
																																foreach $vers_location(@versions)
																																{
																																	my $string=$current_sel_version."~~~".$current_sel_location;
																																	if ($vers_location=~ m/^$string/) 
																																	{
																					
																																		my @array=split('=',$vers_location);
																																		
																																		#my $thread1=threads->new(sub {system(@array[1])});#call,join
																																		#my $thread1=threads->new(system(@array[1]));
																																		#$thread1->join;
																																		#$thread1->detach;
																																		my $pid=fork;
																																		if ($pid==0){
																																			system("xterm");
																																		}
																																	}
																				
																																}
																			
																			
																															}
									
																													}
																		)->place(-x => 30, -y => 185);
																	
										});
						}
						else
						{
							
							
							#execute the command in a separate thread
							print "paths=".@paths[1];
							
#							my $thread=threads->create(sub {system(@paths[1])});
#							$thread->detach;
							my $pid=fork;
							if ($pid==0){
								system("xterm");
							}
							
							if ($lbox_location) {$lbox_location->delete(0, 'end')};
							if ($lbox_version) {$lbox_version->delete(0, 'end')};
							
						}
					});
				}
			}
		}	
	}																		
}																		

#################################################################################
# PURPOSE:             Get index of array element
#
# CALL:                 $index = Indexof($el,@array)
#################################################################################

sub Indexof
{
	my $el = pop @_;                          # Variable which contains the seeked item
	my @array = @_;
	my $ind=-1;
	my $indexa=-1;
	my $elem=undef;
	foreach $elem(@array)
	{
				if ($el ne $elem)
				{
					$ind=$ind+1;

					}
					else

					{
						$indexa=$ind+1;
						}
		}
	return $indexa;
}


#-----------------------------------------------------------------------------
# Implementation
#-----------------------------------------------------------------------------

MainFctAU();

#-----------------------------------------------------------------------------
# Main Funtion
#-----------------------------------------------------------------------------

sub MainFctAU()
{

#for forming the p_ppp format
	#$time_now = get_time();
	$configfile=$ARGV[0];
	#get the projects list
	my $string="Projects";
	@Projects=Get_array($configfile,$string);
	#get the roles list
	$string="Roles";
	@Roles=Get_array($configfile,$string);
	@tools=undef;
	InitWindow();
	# MainLoop for the Tk-GUI
	MainLoop();
	exit(0);



}

#################################################################################
# PURPOSE:              
# CALL:                 @result=Get_array($inputfile,$string)
#    Projects=CSP;Fiat-VP1;Fiat-VP2;MIBE;BMW L7
#    Roles=Architect,Designer,Developer
#################################################################################
sub Get_array
{
	my $inputfile=$_[0];
	my $string=$_[1];
	my $line=undef;
	my @result=undef;
	open (IN, "< $inputfile");
	while ($line = <IN>)
	{
		if ($line =~ m/^$string/)#find string section
		{
						chomp($line);
						my @values = split('=', $line);
						@result=split(';',@values[1]);
		}
		
		
	}
	close(IN);
	return @result;
}

#################################################################################
# PURPOSE:              
# CALL:                 @tools=ParseConfigfile($inputfile,$project,$role)   
# Gets the tools versions and paths 
#################################################################################
sub ParseConfigfile
{
	my $inputfile=$_[0];
	my $project=$_[1];
	my $role=$_[2];
	my @tools = ();  #will keep all the tools listed for a certein role in a certain project 
	my $found=0;
	open (IN, "< $inputfile");
	my $begin_string="begin_".$project."_".$role;
	my $end_string="end_".$project."_".$role;
	my $line=undef;
	my @tools=undef;
	while ($line = <IN>)
	{
		#parse all tools
		
		if ($line =~ m/^$end_string/)#find requirements section
		{
			$found=0;
		}
		if ($found==1)
		{
			push @tools,$line;
		}
		if ($line =~ m/^$begin_string/)#find requirements section
		{
			$found=1;
		}		
	}
	close(IN);
	return @tools;
}

