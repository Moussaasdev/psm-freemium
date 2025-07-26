-- 👤 Insertion d'un utilisateur initial (user de test/admin)
INSERT INTO Users (
    first_name,
    last_name,
    email,
    password_hash,
    full_name,
    birth_date,
    country_code,
    user_status,
    preferred_language,
    is_email_verified,
    subscription_status,
    referral_code,
    referred_by_code,
    is_admin,
    created_at
) VALUES (
    'Admin',
    'Test',
    'admin@test.com',
    'hashed_password',  -- à remplacer par un vrai hash
    'Admin Test',
    '1990-01-01',
    'FR',
    'active',
    'fr',
    1,
    'free',
    NULL,
    NULL,
    1,
    CURRENT_TIMESTAMP
);
