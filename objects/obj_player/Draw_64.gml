var ui_x = 32;
var ui_y = 32;
var bar_w = 240;
var bar_h = 24;
var hp_ratio = hp / max_hp;
hp_ratio = clamp(hp_ratio, 0, 1);

var score_x = ui_x;
var score_y = ui_y + bar_h + 36;

var rhythm_w = 420;
var rhythm_h = 18;
var rhythm_x1 = (display_get_gui_width() - rhythm_w) * 0.5;
var rhythm_y1 = 24;
var rhythm_x2 = rhythm_x1 + rhythm_w;
var rhythm_y2 = rhythm_y1 + rhythm_h;

var marker_t = rhythm_timer / rhythm_interval;
var marker_x = rhythm_x1 + marker_t * rhythm_w;

var sweet_ratio = rhythm_window / rhythm_interval;
var sweet_half_w = max(10, sweet_ratio * rhythm_w);
var sweet_center = rhythm_x1 + rhythm_w * 0.5;
var sweet_x1 = sweet_center - sweet_half_w;
var sweet_x2 = sweet_center + sweet_half_w;
if (sweet_x1 < rhythm_x1) sweet_x1 = rhythm_x1;
if (sweet_x2 > rhythm_x2) sweet_x2 = rhythm_x2;

var dash_cd_ratio = 0;
if (dash_cooldown_time > 0) {
    dash_cd_ratio = 1 - (dash_cooldown / dash_cooldown_time);
}
dash_cd_ratio = clamp(dash_cd_ratio, 0, 1);

// фон панели HP
draw_set_alpha(0.8);
draw_set_color(c_black);
draw_roundrect(ui_x - 8, ui_y - 8, ui_x + bar_w + 8, ui_y + bar_h + 34, false);

// HP
 draw_set_alpha(1);
 draw_set_color(make_color_rgb(60, 60, 60));
 draw_rectangle(ui_x, ui_y, ui_x + bar_w, ui_y + bar_h, false);
 draw_set_color(c_red);
 draw_rectangle(ui_x, ui_y, ui_x + (bar_w * hp_ratio), ui_y + bar_h, false);
 draw_set_color(c_white);
 draw_rectangle(ui_x, ui_y, ui_x + bar_w, ui_y + bar_h, true);
 draw_text(ui_x, ui_y + bar_h + 8, "HP: " + string(floor(hp)) + " / " + string(max_hp));

// Счёт
 draw_set_color(c_white);
 draw_text(score_x, score_y, "SCORE: " + string(score));
 draw_set_color(stance_color);
 draw_text(score_x, score_y + 28, "STANCE: " + stance_name + "  [1-4]");
 draw_set_color(c_white);

// Индикатор ритма сверху
 draw_set_alpha(0.85);
 draw_set_color(c_black);
 draw_roundrect(rhythm_x1 - 12, rhythm_y1 - 12, rhythm_x2 + 12, rhythm_y2 + 42, false);

 draw_set_alpha(1);
 draw_set_color(make_color_rgb(50, 50, 50));
 draw_rectangle(rhythm_x1, rhythm_y1, rhythm_x2, rhythm_y2, false);

 draw_set_color(make_color_rgb(120, 180, 120));
 draw_rectangle(sweet_x1, rhythm_y1, sweet_x2, rhythm_y2, false);

 draw_set_color(c_white);
 draw_rectangle(rhythm_x1, rhythm_y1, rhythm_x2, rhythm_y2, true);
 draw_line_width(marker_x, rhythm_y1 - 4, marker_x, rhythm_y2 + 4, 3);

 draw_text(rhythm_x1, rhythm_y2 + 8, "RHYTHM");
 draw_text(rhythm_x1, rhythm_y2 + 26, "1 Harder  2 Better  3 Faster  4 Stronger");
 var beat_center = rhythm_interval * 0.5;
 if (abs(rhythm_timer - beat_center) <= rhythm_window) {
     draw_text(rhythm_x1 + 90, rhythm_y2 + 8, "ON BEAT");
 } else {
     draw_text(rhythm_x1 + 90, rhythm_y2 + 8, "...");
 }

 // Индикатор CD dash
 var dash_bar_w = 120;
 var dash_bar_h = 12;
 var dash_bar_x = rhythm_x2 - dash_bar_w;
 var dash_bar_y = rhythm_y2 + 12;
 draw_set_color(make_color_rgb(60, 60, 60));
 draw_rectangle(dash_bar_x, dash_bar_y + 18, dash_bar_x + dash_bar_w, dash_bar_y + 18 + dash_bar_h, false);
 draw_set_color(make_color_rgb(120, 180, 255));
 draw_rectangle(dash_bar_x, dash_bar_y + 18, dash_bar_x + dash_bar_w * dash_cd_ratio, dash_bar_y + 18 + dash_bar_h, false);
 draw_set_color(c_white);
 draw_rectangle(dash_bar_x, dash_bar_y + 18, dash_bar_x + dash_bar_w, dash_bar_y + 18 + dash_bar_h, true);
 draw_text(dash_bar_x, dash_bar_y, "DASH CD");

 // Короткий фидбек
 if (rhythm_feedback_timer > 0) {
     draw_set_color(c_white);
     draw_text((display_get_gui_width() * 0.5) - 60, rhythm_y2 + 52, rhythm_feedback_text);
 }
