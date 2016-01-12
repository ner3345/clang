DATA_time_moveStar = 0.2
DATA_time_crushStar = 0.1
DATA_time_scoreShow = 0.025
DATA_time_giftBagChangeInterval = 0.9
DATA_count_fireWork = 8
DATA_count_fireWorkAllAtOnce = 5

DATA_magic_cost = 5
DATA_refresh_cost = 5

DATA_matrix_col = 10
DATA_matrix_row = 10

DATA_scale_changeResolution = 1.5
DATA_pic_width = 480
DATA_pic_height = 853
DATA_pic_kind = 5
DATA_star_side = 72

VERSION="1.0.0"
CHANNEL = "diamondios"

DATA_num_maxLevel = 99
DATA_score_crushBase   = 5
DATA_score_residueStar = {3000,2100,1800,1500,1200,900,600,300,200,100}
DATA_score_passLevel   = 
{
1000,
2500,
4500,
6500,
7500,
9600,
11700,
13800,
15900,
18000,
20120,
22260,
24420,
26600,
28800,
31020,
33260,
35520,
37820,
40140,
42480,
44840,
47220,
49620,
52040,
54480,
56940,
59420,
61920,
64440,
66980,
69540,
72120,
74720,
77340,
79980,
82660,
85360,
88080,
90820,
93580,
96360,
99160,
101980,
104820,
107680,
110560,
113460,
116380,
119320,
122280,
125260,
128260,
131360,
134480,
137620,
140780,
143960,
147160,
150380,
153620,
156880,
160160,
163460,
166780,
170120,
173480,
176860,
180260,
183680,
187120,
190580,
194060,
197560,
201080,
204620,
208180,
211760,
215360,
218980,
222620,
226280,
229960,
233660,
237380,
241120,
244880,
248660,
252460,
256280,
260120,
263980,
267860,
271760,
275680,
279620,
283580,
287560,
291560,
}

DATA_text_GK    =  "关卡"
DATA_text_MB    =  "目标"
DATA_text_MBFS  =  "目标分数"
DATA_text_LX    =  "连消"
DATA_text_F     =  "分"
DATA_text_FS    =  "分数"
DATA_text_SY    =  "剩余"
DATA_text_XXXC  =  "个星星未消除"
DATA_text_HD    =  "获得"
DATA_text_FSJL  =  "分數奖励"
DATA_text_SRDHM =  "请在此输入兑换码"
DATA_text_MAG   =  "使用以下某一顔色替换游戏区域內任意一个心心"
DATA_text_XH    =  "消耗"
DATA_text_GZS   =  "个钻石"
DATA_text_DH    =  "个钻石兌換"
DATA_text_XC3X3 =  "消除3X3的心心"

DATA_price = {
    ["01"] = 1,
    ["02"] = 3,
    ["03"] = 5,
    ["04"] = 10,
    ["05"] = 15,
    ["06"] = 8,
    ["07"] = 0.01
}

DATA_RMB_costList = {6,18,30,68,98}
DATA_costCode_all = {1,2,3,4,5,privilegeGifBag ="06",resurGifBag = "07"}

DAtA_diamond_shop      = {24,108,240,680,1176}

DATA_diamond_magicCost  = {5,20,40,120,200}
DATA_diamond_shopMagicList = {1,5,10,30,60}

DATA_diamond_refreshCost = {5,20,40,120,200}
DATA_diamond_shopRefreshList = {1,5,10,30,60}

DATA_diamond_bombCost = {5,20,40,120,200}
DATA_diamond_shopBombList = {1,5,10,30,60}

DATA_num_giftBagProp = {50,8,8,8}
DATA_num_resurgenceCost = 5
DATA_num_resurgenceGiftBagDiamond = 30
--钻石102，口红是101，香吻是103
DATA_king_passReward = {nil,nil,"102","102","101","103","102","102","101","103","101","103","102","102","102","101","103","101","103","102","102","102","101","103","101","103","102","102","102","101","103","102","102","102","101","103","102","102","102","102","102","102","102","102","102","102","101","103","101","103","102","102","101","103","101","103","102","102","101","103","102","102","102","102","101","103","102","102","102","102","101","103","102","102","102","102","101","103","101","103","102","102","102","101","103","102","102","102","102","101","102","102","102","102"}
DATA_probability_passReward = {0,0,5,7,5,5,9,11,8,8,12,12,13,15,17,15,15,16,16,20,23,26,17,18,20,20,29,32,35,22,22,38,41,44,25,25,47,50,52,28,28,53,54,55,30,30,35,35,56,57,58,37,37,38,38,59,60,40,40,45,45,65,65,50,50,70,70,75,75,55,55,80,80,85,85,60,60,90,90,90,90,70,70,75,75,90,90,90,80,80,90,90,90,90,85,90,90,90,90}
DATA_probability_heartDown = {50,70,85,95,100}
DATA_count_heartDown = {0,1,2,3,4}

DATA_count_LoginSceneShop = 
{
{event_name="商城弹出主界面",label_name="购买优惠大礼包点击"},
{event_name="商城弹出主界面",label_name="购买优惠大礼包成功"},
{event_name="商城弹出主界面",label_name="购买10个钻石点击"},
{event_name="商城弹出主界面",label_name="购买10个钻石成功"},
{event_name="商城弹出主界面",label_name="购买30个钻石点击"},
{event_name="商城弹出主界面",label_name="购买30个钻石成功"},
{event_name="商城弹出主界面",label_name="购买50个钻石点击"},
{event_name="商城弹出主界面",label_name="购买50个钻石成功"},
{event_name="商城弹出主界面",label_name="购买100个钻石点击"},
{event_name="商城弹出主界面",label_name="购买100个钻石成功"},
{event_name="商城弹出主界面",label_name="购买150个钻石点击"},
{event_name="商城弹出主界面",label_name="购买150个钻石成功"},
}
DATA_count_gameSceneShop =
{
{event_name="商城弹出游戏中",label_name="购买优惠大礼包点击"},
{event_name="商城弹出游戏中",label_name="购买优惠大礼包成功"},
{event_name="商城弹出游戏中",label_name="购买10个钻石点击"},
{event_name="商城弹出游戏中",label_name="购买10个钻石成功"},
{event_name="商城弹出游戏中",label_name="购买30个钻石点击"},
{event_name="商城弹出游戏中",label_name="购买30个钻石成功"},
{event_name="商城弹出游戏中",label_name="购买50个钻石点击"},
{event_name="商城弹出游戏中",label_name="购买50个钻石成功"},
{event_name="商城弹出游戏中",label_name="购买100个钻石点击"},
{event_name="商城弹出游戏中",label_name="购买100个钻石成功"},
{event_name="商城弹出游戏中",label_name="购买150个钻石点击"},
{event_name="商城弹出游戏中",label_name="购买150个钻石成功"},
}
DATA_count_gameOverSceneShop =
{
{event_name="商城弹出结束页面",label_name="购买优惠大礼包点击"},
{event_name="商城弹出结束页面",label_name="购买优惠大礼包成功"},
{event_name="商城弹出结束页面",label_name="购买10个钻石点击"},
{event_name="商城弹出结束页面",label_name="购买10个钻石成功"},
{event_name="商城弹出结束页面",label_name="购买30个钻石点击"},
{event_name="商城弹出结束页面",label_name="购买30个钻石成功"},
{event_name="商城弹出结束页面",label_name="购买50个钻石点击"},
{event_name="商城弹出结束页面",label_name="购买50个钻石成功"},
{event_name="商城弹出结束页面",label_name="购买100个钻石点击"},
{event_name="商城弹出结束页面",label_name="购买100个钻石成功"},
{event_name="商城弹出结束页面",label_name="购买150个钻石点击"},
{event_name="商城弹出结束页面",label_name="购买150个钻石成功"},
}

DATA_count_loginSceneGiftBag = 
{
{event_name="优惠大礼包弹窗主界面",label_name="购买优惠大礼包点击"},
{event_name="优惠大礼包弹窗主界面",label_name="购买优惠大礼包成功"},
{event_name="优惠大礼包弹窗主界面",label_name="点击优惠大礼包按钮"},
}
DATA_count_gameSceneGiftBag = 
{
{event_name="优惠大礼包弹窗游戏中",label_name="购买优惠大礼包点击"},
{event_name="优惠大礼包弹窗游戏中",label_name="购买优惠大礼包成功"},
{event_name="优惠大礼包弹窗游戏中",label_name="补充钻石"},
{event_name="优惠大礼包弹窗游戏中",label_name="补充香吻"},
{event_name="优惠大礼包弹窗游戏中",label_name="补充口红"},
}
DATA_count_finallySceneGiftBag = 
{
{event_name="优惠大礼包弹窗结束页面",label_name="购买优惠大礼包点击"},
{event_name="优惠大礼包弹窗结束页面",label_name="购买优惠大礼包成功"},
{event_name="优惠大礼包弹窗结束页面",label_name="点击优惠大礼包按钮"},
{event_name="优惠大礼包弹窗结束页面",label_name="补充钻石"},
}

DATA_count_Resur = 
{
{event_name="复活弹窗RMB游戏结束",label_name="1元复活弹出"},
{event_name="复活弹窗RMB游戏结束",label_name="2元复活弹出"},
{event_name="复活弹窗RMB游戏结束",label_name="复活礼包弹出"},
{event_name="复活弹窗RMB游戏结束",label_name="购买1元复活成功"},
{event_name="复活弹窗RMB游戏结束",label_name="购买2元复活成功"},
{event_name="复活弹窗RMB游戏结束",label_name="购买复活礼包成功"},

{event_name="复活弹窗RMB结束页面点击5钻石复活",label_name="1元复活"},
{event_name="复活弹窗RMB结束页面点击5钻石复活",label_name="购买1元复活成功"},
{event_name="复活弹窗RMB结束页面点击5钻石复活",label_name="2元复活"},
{event_name="复活弹窗RMB结束页面点击5钻石复活",label_name="购买2元复活成功"},
{event_name="复活弹窗RMB结束页面点击5钻石复活",label_name="复活礼包"},
{event_name="复活弹窗RMB结束页面点击5钻石复活",label_name="购买复活礼包成功"},
}

DATA_count_gameOver = 
{

{event_name="游戏结束关卡",label_name="首次结束"},
{event_name="游戏结束关卡",label_name="复活一次后结束"},
{event_name="游戏结束关卡",label_name="复活二次后结束"},
{event_name="游戏结束关卡",label_name="最终结束关卡"},

}