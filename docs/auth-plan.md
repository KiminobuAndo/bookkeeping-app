# 認証機能 実装計画

## Context

簿記学習アプリの MVP に認証機能を追加する。
要件：メール/パスワード/表示名でユーザー登録・ログイン。演習ページはログイン必須、ホームページは誰でも閲覧可能。メール確認は不要。
Devise を使用（README で明記済み）。現時点では User モデルも DB マイグレーションも存在しない。

---

## 実装ステップ

### Step 1: Gemfile に devise を追加

**ファイル**: `Gemfile`

```ruby
gem "devise"
```

その後: `bundle install`

---

### Step 2: Devise インストール

```sh
bin/rails generate devise:install
```

生成される `config/initializers/devise.rb` の設定確認。
`config/environments/development.rb` に以下を追加（メール送信先、フラッシュメッセージ用）:

```ruby
config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
```

---

### Step 3: User モデル生成

```sh
bin/rails generate devise User
```

有効化するモジュール:
- `database_authenticatable` ✅
- `registerable` ✅
- `recoverable` ✅（パスワードリセット。本リリース向けだが Devise デフォルトで含まれるため有効化）
- `rememberable` ✅
- `validatable` ✅
- `confirmable` ❌（コメントアウトのまま）
- `lockable`, `omniauthable` ❌（コメントアウトのまま）

---

### Step 4: name カラムの追加

```sh
bin/rails generate migration AddNameToUsers name:string:null:false
```

`app/models/user.rb` にバリデーション追加:

```ruby
validates :name, presence: true, length: { maximum: 50 }
```

---

### Step 5: マイグレーション実行

```sh
bin/rails db:migrate
```

---

### Step 6: ルーティング更新

**ファイル**: `config/routes.rb`

```ruby
Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
```

※ `resources :posts` はモデル・コントローラが存在しないため削除

---

### Step 7: ApplicationController に認証設定

**ファイル**: `app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
```

**ファイル**: `app/controllers/home_controller.rb`

```ruby
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
end
```

---

### Step 8: Devise ビュー生成 + Tailwind スタイリング

```sh
bin/rails generate devise:views
```

スタイリング対象:
- `app/views/devise/sessions/new.html.erb` — ログイン
- `app/views/devise/registrations/new.html.erb` — ユーザー登録（name フィールド追加）
- `app/views/devise/registrations/edit.html.erb` — プロフィール編集

各フォームに Tailwind CSS クラスを適用（input、button 等）。

---

### Step 9: レイアウトにナビゲーションバー追加

**ファイル**: `app/views/layouts/application.html.erb`

`<body>` 内に共通ナビを追加:

```erb
<nav>
  <% if user_signed_in? %>
    <%= current_user.name %> さん
    <%= button_to "ログアウト", destroy_user_session_path, method: :delete %>
  <% else %>
    <%= link_to "ログイン", new_user_session_path %>
    <%= link_to "新規登録", new_user_registration_path %>
  <% end %>
</nav>
```

---

### Step 10: テスト追加

**ファイル**: `test/fixtures/users.yml`
```yaml
one:
  email: test@example.com
  encrypted_password: <%= BCrypt::Password.create("password") %>
  name: テストユーザー
```

**ファイル**: `test/models/user_test.rb` — バリデーションテスト（name 必須、email 必須）

**ファイル**: `test/system/auth_test.rb` — ログイン・登録フローのシステムテスト

---

## 変更ファイル一覧

| ファイル | 操作 |
|---------|------|
| `Gemfile` | devise 追加 |
| `config/environments/development.rb` | mailer default_url_options 追加 |
| `config/initializers/devise.rb` | 自動生成 |
| `config/routes.rb` | devise_for :users 追加、posts 削除 |
| `db/migrate/*_devise_create_users.rb` | 自動生成 |
| `db/migrate/*_add_name_to_users.rb` | 生成 |
| `app/models/user.rb` | 自動生成 + name バリデーション追加 |
| `app/controllers/application_controller.rb` | authenticate_user! + permitted params |
| `app/controllers/home_controller.rb` | skip_before_action 追加 |
| `app/views/devise/**` | 自動生成 + Tailwind スタイリング |
| `app/views/layouts/application.html.erb` | ナビバー追加 |
| `test/fixtures/users.yml` | 新規作成 |
| `test/models/user_test.rb` | 新規作成 |
| `test/system/auth_test.rb` | 新規作成 |

---

## 検証方法

```sh
# 1. サーバー起動
bin/dev

# 2. 動作確認
# - http://localhost:3000 → ホーム表示（未ログインでも OK）
# - http://localhost:3000/users/sign_in → ログイン画面
# - http://localhost:3000/users/sign_up → 登録画面（name フィールドあり）
# - 登録 → ホームへリダイレクト、ナビバーにユーザー名表示
# - ログアウト → ホームへリダイレクト

# 3. テスト実行
bin/rails test test/models/user_test.rb
bin/rails test:system
bin/rails test
```
