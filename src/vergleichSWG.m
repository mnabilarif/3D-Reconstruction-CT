function para_out = vergleichSWG(merkmal_in,para)

% ------------------------------ Vergleich ----------------------------------
diff_poro = para.porositaet_soll - merkmal_in.porositaet;

% ----------------------- Stellwert generierung -----------------------------
global diff_sum
if isempty(diff_sum)
    diff_sum = 0;
end
diff_sum = diff_poro + diff_sum;
para.Kth = para.Kth + diff_poro * para.Kp + diff_sum * para.Ki;
para_out = para;
end