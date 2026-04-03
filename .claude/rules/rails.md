# Rails

- 認証ロジックは Devise に委ねる。独自の認証実装を追加しない
- クイズの進行状態（`question_ids`, `current_index`）は `session` で管理される。DBに持たせない
- 新しいビジネスロジックは `app/services/` に Service オブジェクトとして切り出す（`AnswerGrader` の例に倣う）
- スキーマの変更は必ずマイグレーションで行い、`db/schema.rb` を直接編集しない
