-- ============================================================================
-- ScreenTime Landing — signup_emails
-- Captures email signups for the "Plus" tier waitlist from the marketing site.
-- Write-only from the browser: anon role can INSERT; SELECT/UPDATE/DELETE denied.
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public.signup_emails (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT NOT NULL,
    source TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT signup_emails_email_unique UNIQUE (email)
);

-- Enforce lowercase-normalized email storage so duplicates collapse regardless of input casing.
CREATE OR REPLACE FUNCTION public.signup_emails_normalize_email()
RETURNS TRIGGER AS $$
BEGIN
    NEW.email = lower(trim(NEW.email));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER signup_emails_normalize_email_trg
    BEFORE INSERT OR UPDATE ON public.signup_emails
    FOR EACH ROW
    EXECUTE FUNCTION public.signup_emails_normalize_email();

CREATE INDEX IF NOT EXISTS signup_emails_created_at_idx
    ON public.signup_emails(created_at DESC);

ALTER TABLE public.signup_emails ENABLE ROW LEVEL SECURITY;

-- Anon can submit emails. No SELECT/UPDATE/DELETE policies = those are denied.
CREATE POLICY "signup_emails_insert_anon"
    ON public.signup_emails
    FOR INSERT
    TO anon
    WITH CHECK (true);
