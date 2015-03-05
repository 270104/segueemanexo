#!/usr/bin/perl

use LWP::UserAgent;
use HTTP::Request::Common qw(GET);
$ag = LWP::UserAgent->new();
$ag->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ag->timeout(10);

chomp(my $dork = $ARGV[0]);
system "title Pesquisando = $dork";
for ($i = 1; $i <= 10000; $i+=10){
$url = "http://www.bing.com/search?q=$dork&go=&qs=ds&filt=all&first=$i&FORM=PERE";
$resp = $ag->request(HTTP::Request->new(GET => $url));
$rrs = $resp->content;

while($rrs =~ m/<a href=\"?http:\/\/(.*?)\//g){
$link = $1;
if ( $link !~ /overture|msn|live|bing|wikipedia|google|orkut|yahoo|youtube|microsof|blogspot/){
if ($link !~ /^http:/){$link = 'http://' . "$link" . '/';}
if($link !~ /\"|\?|\=|index\.php/){
print "\n\t $link";
push(@resul,$link);}} }

while($rrs =~ m/<a href=\"?http:\/\/(.*?[\/].*?)\//g){
$link = $1;
if ( $link !~ /overture|msn|live|bing|wikipedia|google|orkut|yahoo|youtube|microsof|blogspot/){
if ($link !~ /^http:/){$link = 'http://' . "$link" . '/';}
if($link !~ /\"|\?|\=|index\.php/){
print "\n\t $link";
push(@resul,$link);}} }

if ($rrs !~ m/class=\"sb_pagN\"/g){
$total = $#resul+1;
open(TXTS,"<rRS.txt"); chomp(@ar = <TXTS>); close(TXTS); push(@resul,@ar);
open (TXT,">rRS.txt");
foreach(@resul){$c{$_}++;next if $c{$_} > 1;print TXT "$_\n";push(@arq,$_);}
close(TXT);
$arq=$#arq+1;
print "\n\n Total Resultado $total , total em arquivo $arq\n"; exit; }
}