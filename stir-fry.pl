#!/usr/bin/perl

use warnings;
use strict;
use lib '/users/u18/eli/';
use XML::DOM::Lite qw(Parser);
use CGI;

sub get_stir_fry {
	my @weekdays = ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
	my @stirfry;
	my ($node,$text,$id,$j);
	my $dom = Parser->parseFile("/users/u18/eli/stirfry/gracies-weekly.cfm", whitespace => 'strip');
	for (my $i=0;$i<7;$i++) {
		for (my $k=0;$k<3;$k++) {
			$j=0;
			$id = 'meal_' . $weekdays[$i] . '_' . ($k+1);
			$node = $dom->getElementById($id);
			if ($node eq "") { $stirfry[$i][$k] = "No data"; $j=1;}
			if ($j==0) {
				$text = $node->xml;
				if ($text =~ m/Stir( |-)Fry/i) {
					$stirfry[$i][$k] = "Yes";
				} else {
					$stirfry[$i][$k] = "No";
				}
			}
		}
	}

	return @stirfry;
}

my @weekdays = ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
my @stir_fry = get_stir_fry(@weekdays);

my $breakfast = 0;
for (my $i=0;$i<7;$i++) {
	if ($stir_fry[$i][0] eq "Yes") {
		$breakfast = 1;
	}
}

my $page = new CGI;

print $page->start_html( -title => "Stir Weekdays",
                         -script => { -type => "JavaScript",
						              -src  => "stirfry.js" }
				       );
print $page->h1({-align => 'center'},"Is there stir fry* today?");
print $page->start_table({-border => 1,-align => 'center'});
print $page->start_Tr({-style => 'background-color:lightgrey;'});
print $page->td("Weekday");
if ($breakfast) {
	print $page->td("Breakfast");
}
print $page->td("Lunch");
print $page->td("Dinner");
print $page->end_Tr;

for (my $i=0;$i<7;$i++) {
	print $page->start_Tr({-id => (($i+1) % 7)});
	print $page->start_td;
	print $page->strong($weekdays[$i]);
	print $page->end_td;
	for (my $k=0;$k<3;$k++) {
		if ($k != 0 || $breakfast) {
		   print $page->td({-id => (($i+1) % 7) . ".$k"},$stir_fry[$i][$k]);
		 }
	}
	print $page->end_Tr;
}

print $page->end_table;
print $page->div({-style => 'position:absolute;bottom:0;font-size:75%;'},"*Asian stir fry only. Thai stir fry is gross.");
print $page->start_div({-style => 'position:absolute;bottom:0;right:5px;font-size:75%;'});
print $page->a({-href => 'https://github.com/ewenig/stirfry'},"We're on Github now apparently");
print $page->end_div;
print $page->br;
print $page->end_html;
