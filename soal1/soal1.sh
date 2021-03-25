#!/bin/bash

#1.d)
#Filter semua isi dari pesan log untuk nantinya dihitung
fil_deny="$(grep 'Permission' syslog.log | wc -l)"
fil_modif="$(grep 'modified' syslog.log | wc -l)"
fil_closed="$(grep 'closed' syslog.log | wc -l)"
fil_timeout="$(grep 'Timeout' syslog.log | wc -l)"
fil_failed="$(grep 'Connection' syslog.log | wc -l)"
fil_exist="$(grep 'exist' syslog.log | wc -l)"

#Print semua filter yang telah dibuat serta melakukan sort
printf "Permission Denied,%d\nModified,%d\nClosed Ticket,%d\nTimeout,%d\nConnection to DB Failed,%d\nFile not found,%d\n" $fil_deny $fil_modif $fil_closed $fil_timeout $fil_failed $fil_exist | sort -t, -nr -k2| sed '1i\Error,Count' > error_message.csv

#1.e)
#Filter untuk mdouglas
md_info="$(grep 'INFO.*(mdouglas)' syslog.log | wc -l)"
md_error="$(grep 'ERROR.*(mdouglas)' syslog.log | wc -l)"
#Filter untuk noel
noel_info="$(grep 'INFO.*(noel)' syslog.log | wc -l)"
noel_error="$(grep 'ERROR.*(noel)' syslog.log | wc -l)"
#Filter untuk breee
breee_info="$(grep 'INFO.*(breee)' syslog.log | wc -l)"
breee_error="$(grep 'ERROR.*(breee)' syslog.log | wc -l)"
#Filter untuk ac
ac_info="$(grep 'INFO.*(ac)' syslog.log | wc -l)"
ac_error="$(grep 'ERROR.*(ac)' syslog.log | wc -l)"
#Filter untuk blossom
bl_info="$(grep 'INFO.*(blossom)' syslog.log | wc -l)"
bl_error="$(grep 'ERROR.*(blossom)' syslog.log | wc -l)"
#Filter untuk rr.robinson
rob_info="$(grep 'INFO.*(rr.robinson)' syslog.log | wc -l)"
rob_error="$(grep 'ERROR.*(rr.robinson)' syslog.log | wc -l)"
#Filter untuk mcintosh
mc_info="$(grep 'INFO.*(mcintosh)' syslog.log | wc -l)"
mc_error="$(grep 'ERROR.*(mcintosh)' syslog.log | wc -l)"
#Filter untuk jackowens
jo_info="$(grep 'INFO.*(jackowens)' syslog.log | wc -l)"
jo_error="$(grep 'ERROR.*(jackowens)' syslog.log | wc -l)"
#Filter untuk oren
oren_info="$(grep 'INFO.*(oren)' syslog.log | wc -l)"
oren_error="$(grep 'ERROR.*(oren)' syslog.log | wc -l)"
#Filter untuk xlg
xlg_info="$(grep 'INFO.*(xlg)' syslog.log | wc -l)"
xlg_error="$(grep 'ERROR.*(xlg)' syslog.log | wc -l)"
#Filter untuk ahmed.miller
am_info="$(grep 'INFO.*(ahmed.miller)' syslog.log | wc -l)"
am_error="$(grep 'ERROR.*(ahmed.miller)' syslog.log | wc -l)"
#Filter untuk bpachehco
bp_info="$(grep 'INFO.*(bpacheco)' syslog.log | wc -l)"
bp_error="$(grep 'ERROR.*(bpacheco)' syslog.log | wc -l)"
#Filter untuk enim.non
en_info="$(grep 'INFO.*(enim.non)' syslog.log | wc -l)"
en_error="$(grep 'ERROR.*(enim.non)' syslog.log | wc -l)"
#Fiter untuk flavia
fla_info="$(grep 'INFO.*(flavia)' syslog.log | wc -l)"
fla_error="$(grep 'ERROR.*(flavia)' syslog.log | wc -l)"
#Filter untuk sri
sri_info="$(grep 'INFO.*(sri)' syslog.log | wc -l)"
sri_error="$(grep 'ERROR.*(sri)' syslog.log | wc -l)"
#Filter untuk nonummy
no_info="$(grep 'INFO.*(nonummy)' syslog.log | wc -l)"
no_error="$(grep 'ERROR.*(nonummy)' syslog.log | wc -l)"
#Filter untuk britanni
bri_info="$(grep 'INFO.*(britanni)' syslog.log | wc -l)"
bri_error="$(grep 'ERROR.*(britanni)' syslog.log | wc -l)"
#Filter untuk montanap
mon_info="$(grep 'INFO.*(montanap)' syslog.log | wc -l)"
mon_error="$(grep 'ERROR.*(montanap)' syslog.log | wc -l)"
#Filter untuk mai.hendrix
mai_info="$(grep 'INFO.*(mai.hendrix)' syslog.log | wc -l)"
mai_error="$(grep 'ERROR.*(mai.hendrix)' syslog.log | wc -l)"
#Filter untuk kirknixon
kirk_info="$(grep 'INFO.*(kirknixon)' syslog.log | wc -l)"
kirk_error="$(grep 'ERROR.*(kirknixon)' syslog.log | wc -l)"

#Print sesuai soal
printf "mdouglas,%d,%d\nnoel,%d,%d\nbreee,%d,%d\nac,%d,%d\nblossom,%d,%d\nrr.robinson,%d,%d\nmcintosh,%d,%d\njackowens,%d,%d\noren,%d,%d\nxlg,%d,%d\nahmed.miller,%d,%d\nbpacheco,%d,%d\nenim.non,%d,%d\nflavia,%d,%d\nsri,%d,%d\nnonummy,%d,%d\nbritanni,%d,%d\nmontanap,%d,%d\nmai.hendrix,%d,%d\nkirknixon,%d,%d\n" $md_info $md_error $noel_info $noel_error $breee_info $breee_error $ac_info $ac_error $bl_info $bl_error $rob_info $rob_error $mc_info $mc_error $jo_info $jo_error $oren_info $oren_error $xlg_info $xlg_error $am_info $am_error $bp_info $bp_error $en_info $en_error $fla_info $fla_error $sri_info $sri_error $no_info $no_error $bri_info $bri_error $mon_info $mon_error $mai_info $mai_error $kirk_info $kirk_error | sort -t, -k1 | sed '1i\Username,INFO,ERROR' > user_statistic.csv

