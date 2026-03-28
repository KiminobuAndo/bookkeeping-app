# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

course = Course.find_or_create_by!(name: "借方・貸方 現金勘定どっち？？") do |c|
  c.is_published = true
end

Question.find_or_create_by!(
  course: course,
  prompt: "収入印紙 ¥2,700 と郵便切手 ¥450 を現金で購入し、すぐに使用した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 3150
)

# ===== Aランク =====

Question.find_or_create_by!(
  course: course,
  prompt: "商品運搬用の軽自動車3台を購入し、代金のうち ¥2,000,000 は小切手を振り出して支払い、残額は分割払いとした。購入に伴う諸費用 ¥60,000 は現金で支払った。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 2000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "従業員への給料総額 ¥2,000,000 から社会保険料 ¥250,000 を差し引き、残額を普通預金口座から振り込んだ。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 1750000
)

Question.find_or_create_by!(
  course: course,
  prompt: "借入金 ¥3,000,000 を9か月分の利息 ¥90,000 とともに小切手を振り出して支払った。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 3090000
)

Question.find_or_create_by!(
  course: course,
  prompt: "源泉徴収した所得税 ¥600,000 を税務署の納税窓口にて現金で納付した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 600000
)

Question.find_or_create_by!(
  course: course,
  prompt: "松平銀行と今川銀行に普通預金口座を開設し、それぞれの口座に ¥1,000,000 ずつ現金を預け入れた。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 2000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "貸付金 ¥3,000,000 を9か月分の利息 ¥90,000 とともに、相手先振り出しの小切手で回収した。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 3090000
)

Question.find_or_create_by!(
  course: course,
  prompt: "3年間使用した事務機器を期首に ¥100,000 で売却し、代金は現金で受け取った。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 100000
)

Question.find_or_create_by!(
  course: course,
  prompt: "会社設立にあたり、株式を発行し、全額の払込みを受けて当座預金とした。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 600000
)

Question.find_or_create_by!(
  course: course,
  prompt: "前期に貸倒処理していた売掛金 ¥100,000 が普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 100000
)

Question.find_or_create_by!(
  course: course,
  prompt: "従業員の出張にあたり、旅費の概算額 ¥50,000 を現金で手渡した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 50000
)

Question.find_or_create_by!(
  course: course,
  prompt: "給料から差し引いた社会保険料の従業員負担額と会社負担額をまとめて現金で納付した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 500000
)

Question.find_or_create_by!(
  course: course,
  prompt: "出張中の従業員から ¥60,000 の送金小切手が会社宛てに送られてきたが、現時点では内容不明である。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 60000
)

Question.find_or_create_by!(
  course: course,
  prompt: "土地を購入し、登記費用を含めた合計額を小切手を振り出して支払った。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 3100000
)

Question.find_or_create_by!(
  course: course,
  prompt: "給料総額 ¥1,000,000 から従業員貸付金返済分 ¥200,000 と所得税 ¥100,000 を差し引き、手取額を当座預金口座から支給した。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 700000
)

Question.find_or_create_by!(
  course: course,
  prompt: "宇喜多銀行の普通預金口座から毛利銀行の普通預金口座へ ¥500,000 を振り込み、手数料 ¥500 が発生した。毛利銀行の普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 500000
)

Question.find_or_create_by!(
  course: course,
  prompt: "宇喜多銀行の普通預金口座から毛利銀行の普通預金口座へ ¥500,000 を振り込み、手数料 ¥500 が発生した。宇喜多銀行の普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 500500
)

Question.find_or_create_by!(
  course: course,
  prompt: "従業員が出張から戻り、旅費の残額 ¥10,000 と得意先から回収した売掛金 ¥60,000 を現金で受け取った。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 70000
)

Question.find_or_create_by!(
  course: course,
  prompt: "固定資産税の第1期分 ¥180,000 を現金で納付した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 180000
)

Question.find_or_create_by!(
  course: course,
  prompt: "決算で現金実査をしたところ帳簿残高と実際有高に差額があり、原因調査の結果を反映した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 18200
)

Question.find_or_create_by!(
  course: course,
  prompt: "当座借越契約のある状態で商品 ¥600,000 を小切手を振り出して支払った。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 600000
)

Question.find_or_create_by!(
  course: course,
  prompt: "収入印紙 ¥5,000 と郵便切手 ¥10,000 を郵便局で購入し、代金は現金で支払った。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 15000
)

Question.find_or_create_by!(
  course: course,
  prompt: "法人税・住民税・事業税の中間申告分を現金で納付した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 250000
)

# ===== Bランク =====

Question.find_or_create_by!(
  course: course,
  prompt: "商品 ¥450,000 を販売し、代金のうち ¥300,000 は以前に当社が振り出した小切手を受け取り、残額は掛けとした。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 300000
)

Question.find_or_create_by!(
  course: course,
  prompt: "店舗拡張のため ¥3,000,000 を借り入れ、全額が普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 3000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "土地の仲介手数料 ¥200,000 を現金で支払った。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 200000
)

Question.find_or_create_by!(
  course: course,
  prompt: "売掛金 ¥200,000 の決済日に、振込手数料 ¥550 が差し引かれた残額が普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 199450
)

Question.find_or_create_by!(
  course: course,
  prompt: "年利3%、4か月の条件で ¥1,000,000 を貸し付け、同額の約束手形を受け取り、利息を差し引いた残額を普通預金口座から振り込んだ。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 990000
)

Question.find_or_create_by!(
  course: course,
  prompt: "増資を行い、全額の払込みを受け、払込金は普通預金とした。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 500000
)

Question.find_or_create_by!(
  course: course,
  prompt: "加入している業界団体の年会費 ¥20,000 を現金で支払った。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 20000
)

Question.find_or_create_by!(
  course: course,
  prompt: "小口現金係への補給として、小切手 ¥10,000 を振り出した。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 10000
)

Question.find_or_create_by!(
  course: course,
  prompt: "倉庫使用料 ¥100,000 を当社の普通預金から支払った。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 100000
)

Question.find_or_create_by!(
  course: course,
  prompt: "商品 ¥250,000 を販売し、代金は同店振り出しの小切手を受け取り、ただちに普通預金口座に預け入れた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 250000
)

Question.find_or_create_by!(
  course: course,
  prompt: "買掛金 ¥300,000 を普通預金から支払い、振込手数料 ¥550 を負担した。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 300550
)

Question.find_or_create_by!(
  course: course,
  prompt: "¥3,000,000 を貸し付け、当社の普通預金口座から相手先の普通預金口座に全額を振り込んだ。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 3000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "売掛金と買掛金を相殺し、超過分 ¥100,000 は相手先振り出しの小切手を受け取り、ただちに当座預金口座に預け入れた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 100000
)

Question.find_or_create_by!(
  course: course,
  prompt: "不要となった備品の売却代金 ¥150,000 が普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 150000
)

Question.find_or_create_by!(
  course: course,
  prompt: "売上代金の一部として受け取った自治体発行の商品券 ¥200,000 について、換金請求を行ったところ当座預金口座に振り込まれた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 200000
)

Question.find_or_create_by!(
  course: course,
  prompt: "営業用自動車にかかる自動車税 ¥30,000 を現金で納付した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 30000
)

Question.find_or_create_by!(
  course: course,
  prompt: "売上代金の一部として受け取った小切手を当座預金口座に預け入れた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 2000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "土地の賃借料 ¥200,000 が京極銀行の当座預金口座から引き落とされた。当座預金京極銀行は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 200000
)

Question.find_or_create_by!(
  course: course,
  prompt: "前期末に計上した法人税等の未払分 ¥350,000 を現金で納付した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 350000
)

Question.find_or_create_by!(
  course: course,
  prompt: "商品を売り上げ、配送料 ¥2,000 は現金で支払った。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 2000
)

# ===== サンプル問題PDFベース（問題文から算出） =====

Question.find_or_create_by!(
  course: course,
  prompt: "従業員の給料 ¥550,000 を支給するにあたり、所得税 ¥27,500 と社会保険料 ¥50,000 を差し引き、残額を普通預金口座から支払った。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 472500
)

Question.find_or_create_by!(
  course: course,
  prompt: "収入印紙 ¥2,700 と郵便切手 ¥450 を現金で購入し、すぐに使用した。現金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 3150
)

Question.find_or_create_by!(
  course: course,
  prompt: "電子記録債務 ¥720,000 が決済され、当座預金口座から引き落とされた。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 720000
)

Question.find_or_create_by!(
  course: course,
  prompt: "商品 ¥210,000 を売り上げ、代金のうち ¥60,000 は現金で受け取り、残額は共通商品券で受け取った。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 60000
)

Question.find_or_create_by!(
  course: course,
  prompt: "買掛金 ¥200,000 を当座預金口座から返済した。当座借越契約がある。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 200000
)

Question.find_or_create_by!(
  course: course,
  prompt: "従業員に手渡していた旅費交通費 ¥100,000 のうち、残額 ¥9,500 を従業員から現金で受け取った。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 9500
)

Question.find_or_create_by!(
  course: course,
  prompt: "銀行から ¥5,000,000 を借り入れ、同額の約束手形を振り出し、利息を差し引かれた手取金を当座預金とした。借入期間10か月、年利2.4%。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 4900000
)

Question.find_or_create_by!(
  course: course,
  prompt: "増資により株式7,000株を1株 ¥900 で発行し、払込金は普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 6300000
)

Question.find_or_create_by!(
  course: course,
  prompt: "事務所の賃貸借契約を結び、家賃6か月分 ¥1,500,000、手数料 ¥250,000、敷金 ¥300,000 を小切手を振り出して支払った。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 2050000
)

Question.find_or_create_by!(
  course: course,
  prompt: "約束手形による借入金 ¥2,000,000 の満期日に、同額が当座預金口座から引き落とされた。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 2000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "土地付き建物を購入し、代金・不動産会社手数料・印紙税を普通預金口座から振り込んだ。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 12895000
)

Question.find_or_create_by!(
  course: course,
  prompt: "賃貸借契約を解約し、敷金から修繕費 ¥150,000 を差し引かれた残額 ¥320,000 が普通預金口座へ振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 320000
)

Question.find_or_create_by!(
  course: course,
  prompt: "店舗兼事務所として使用している不動産の固定資産税 ¥150,000 を普通預金口座から納付した。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 150000
)

Question.find_or_create_by!(
  course: course,
  prompt: "電子記録債権 ¥750,000 が決済され、同額が当座預金口座に振り込まれた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 750000
)

Question.find_or_create_by!(
  course: course,
  prompt: "不用になった備品を ¥250,000 で売却し、代金は月末に普通預金口座に振り込んでもらうこととした。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 250000
)

Question.find_or_create_by!(
  course: course,
  prompt: "かねて受け取っていた約束手形 ¥870,000 が決済され、同額が当座預金口座に入金された。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 870000
)

Question.find_or_create_by!(
  course: course,
  prompt: "所得税の源泉徴収額 ¥50,000 を普通預金口座から納付した。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 50000
)

Question.find_or_create_by!(
  course: course,
  prompt: "建物の賃貸借契約を解約し、保証金 ¥240,000 から修繕費 ¥85,000 を差し引かれた残額が普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 155000
)

Question.find_or_create_by!(
  course: course,
  prompt: "普通預金口座から当座預金口座に ¥2,000,000 を振り替えた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 2000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "株式会社設立にあたり、株式4,000株を1株 ¥380 で発行し、払込金額は普通預金とした。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 1520000
)

Question.find_or_create_by!(
  course: course,
  prompt: "約束手形を受け取って貸し付けていた ¥2,000,000 の満期日に、同額が当座預金口座に振り込まれた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 2000000
)

Question.find_or_create_by!(
  course: course,
  prompt: "社会保険料について、従業員負担分 ¥45,000 と会社負担分 ¥45,000 の合計額を普通預金口座から納付した。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 90000
)

Question.find_or_create_by!(
  course: course,
  prompt: "店舗を建てる目的で土地 ¥5,000,000 を購入し、不動産会社への手数料 ¥150,000 を含めた合計額を小切手を振り出して支払った。当座預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 5150000
)

Question.find_or_create_by!(
  course: course,
  prompt: "店頭売上のうち ¥33,400 は現金決済であった。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 33400
)

Question.find_or_create_by!(
  course: course,
  prompt: "借入金 ¥800,000 の返済日に、元利合計を普通預金口座から返済した。借入期間9か月、年利1.8%。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 810800
)

Question.find_or_create_by!(
  course: course,
  prompt: "給料 ¥600,000 の支給に際し、所得税 ¥32,000、住民税 ¥43,000、社会保険料 ¥52,000 を差し引いた残額を普通預金口座から支払った。普通預金は借方・貸方どちら？",
  correct_side: "credit",
  correct_amount: 473000
)

Question.find_or_create_by!(
  course: course,
  prompt: "賃借契約を解約し、敷金 ¥360,000 から修繕費 ¥122,000 を差し引かれた残額が当座預金口座に振り込まれた。当座預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 238000
)

Question.find_or_create_by!(
  course: course,
  prompt: "増資に際し、株式4,000株を1株 ¥360 で発行し、払込金が普通預金口座に振り込まれた。普通預金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 1440000
)

Question.find_or_create_by!(
  course: course,
  prompt: "商品 ¥450,000 を売り上げ、代金のうち ¥90,000 は現金で受け取り、残額は約束手形で受け取った。現金は借方・貸方どちら？",
  correct_side: "debit",
  correct_amount: 90000
)