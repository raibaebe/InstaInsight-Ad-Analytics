-- 1. Distribution of ads per platform
SELECT ad_platform, COUNT(*) AS total_ads
FROM ads
GROUP BY ad_platform
ORDER BY total_ads DESC;

-- 2. Distribution of ads per ad type
SELECT ad_type, COUNT(*) AS total_ads
FROM ads
GROUP BY ad_type
ORDER BY total_ads DESC;

-- 3. Distribution of ads per targeted gender
SELECT target_gender, COUNT(*) AS total_ads
FROM ads
GROUP BY target_gender
ORDER BY total_ads DESC;

-- 4. Distribution of ads per targeted interests
SELECT target_interests, COUNT(*) AS total_ads
FROM ads
GROUP BY target_interests
ORDER BY total_ads DESC;

-- 5. Distribution of ad type across platforms
SELECT ad_platform, ad_type, COUNT(*) AS total_ads
FROM ads
GROUP BY ad_platform, ad_type
ORDER BY ad_platform, total_ads DESC;

-- 6. Convert target age group into numeric value (safe)
SELECT ad_id,
       target_age_group,
       CAST(SPLIT_PART(target_age_group, '-', 1) AS INT) AS age_from,
       CAST(SPLIT_PART(target_age_group, '-', 2) AS INT) AS age_to
FROM ads
WHERE target_age_group ~ '^[0-9]+-[0-9]+$';

-- 7. Distribution of ad type per age group
SELECT target_age_group, ad_type, COUNT(*) AS total_ads
FROM ads
GROUP BY target_age_group, ad_type
ORDER BY target_age_group, total_ads DESC;

-- 8. Average target age for different ad types across platforms (safe)
SELECT ad_platform, ad_type,
       AVG((CAST(SPLIT_PART(target_age_group, '-', 1) AS INT) +
            CAST(SPLIT_PART(target_age_group, '-', 2) AS INT)) / 2.0) AS avg_target_age
FROM ads
WHERE target_age_group ~ '^[0-9]+-[0-9]+$'
GROUP BY ad_platform, ad_type
ORDER BY ad_platform, ad_type;

-- 9. Distribution of ad platform per gender
SELECT ad_platform, target_gender, COUNT(*) AS total_ads
FROM ads
GROUP BY ad_platform, target_gender
ORDER BY ad_platform, total_ads DESC;

-- 10. Count of ads for different genders across platforms
SELECT ad_platform, target_gender, COUNT(*) AS total_ads
FROM ads
GROUP BY ad_platform, target_gender
ORDER BY ad_platform, total_ads DESC;

-- 11. Average targeted age by ad platform and gender (safe)
SELECT ad_platform, target_gender,
       AVG((CAST(SPLIT_PART(target_age_group, '-', 1) AS INT) +
            CAST(SPLIT_PART(target_age_group, '-', 2) AS INT)) / 2.0) AS avg_target_age
FROM ads
WHERE target_age_group ~ '^[0-9]+-[0-9]+$'
GROUP BY ad_platform, target_gender
ORDER BY ad_platform, target_gender;
