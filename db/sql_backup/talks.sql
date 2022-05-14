--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: talks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (2, 2, '令和3年3月18日開催ウェブセミナー「高齢者施設等における感染やクラスター発生時の対応」～支援と受援の経験と教訓を共有して地域ぐるみで強くなる～', '4f4c6c0348349f', false, false, NULL, '2022-05-14 15:24:05', 1, 0, '2022-05-14 15:23:54.725597', '2022-05-14 15:24:11.506799');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (3, 2, '新型コロナウイルス感染症への対応について（高齢者の皆さまへ）', '2f6d644413be11', false, false, NULL, '2022-05-14 15:25:40', 1, 0, '2022-05-14 15:25:32.37712', '2022-05-14 15:25:57.088389');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (4, 1, '新型コロナウイルス感染症への対応について（在宅介護家族の皆さまへ）', 'c7b07b0e8edcff', false, false, NULL, '2022-05-14 15:27:27', 1, 0, '2022-05-14 15:26:58.581133', '2022-05-14 15:27:27');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (5, 2, '介護事業所等における新型コロナウイルス感染症への対応等について', 'b6b01802a3e5c4', false, false, NULL, '2022-05-14 15:28:38', 1, 0, '2022-05-14 15:28:08.280248', '2022-05-14 15:28:38');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (6, 1, '介護保険制度について（40歳になられた方（第２号被保険者）向け：令和２年11月版）', '2b6771cb36c592', false, false, NULL, '2022-05-14 15:29:33', 1, 0, '2022-05-14 15:29:14.373268', '2022-05-14 15:29:33');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (7, 2, '介護の日・福祉人材確保重点実施期間', 'ee2c4bedd2f064', false, false, NULL, '2022-05-14 15:30:36', 1, 0, '2022-05-14 15:30:07.793067', '2022-05-14 15:30:36');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (8, 1, '介護離職ゼロ　ポータルサイト', '21a487abc22c2e', false, false, NULL, '2022-05-14 15:31:44', 1, 0, '2022-05-14 15:31:12.629904', '2022-05-14 15:31:44');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (9, 2, '介護納付金算定に係る事務誤り事案について', '33e84c5fdd2517', false, false, NULL, '2022-05-14 15:32:20', 1, 0, '2022-05-14 15:32:08.799601', '2022-05-14 15:32:20');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (10, 1, '「地域がいきいき　集まろう！通いの場」　特設Webサイトを公開します', '2172e103441cf3', false, false, NULL, '2022-05-14 15:32:56', 1, 0, '2022-05-14 15:32:44.333569', '2022-05-14 15:32:56');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (11, 1, '介護サービス関係Ｑ＆Ａ', '02f581ad540600', false, false, NULL, '2022-05-14 15:34:59', 1, 0, '2022-05-14 15:34:43.118152', '2022-05-14 15:34:59');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (12, 2, '介護保険財政', '5d4dde455831c7', false, false, NULL, '2022-05-14 15:35:41', 1, 0, '2022-05-14 15:35:27.453227', '2022-05-14 15:35:41');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (13, 1, '介護ロボットの開発・普及の促進', '53c7b592445900', false, false, NULL, '2022-05-14 15:37:38', 1, 0, '2022-05-14 15:37:01.124943', '2022-05-14 15:37:38');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (14, 1, '高齢者虐待防止', 'bf96048c0a81c8', false, false, NULL, '2022-05-14 15:39:35', 1, 0, '2022-05-14 15:39:19.957015', '2022-05-14 15:39:35');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (15, 2, '保険者機能強化推進交付金及び介護保険保険者努力支援交付金', '57f1b04da4c829', false, false, NULL, '2022-05-14 15:40:16', 1, 0, '2022-05-14 15:40:04.205363', '2022-05-14 15:40:16');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (16, 1, '要介護認定', '7abfa81bf5ec4b', false, false, NULL, '2022-05-14 15:42:15', 1, 0, '2022-05-14 15:42:02.302327', '2022-05-14 15:42:15');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (1, 1, '福祉・介護新型コロナウイルス感染症への対応について（高齢者の皆さまへ）', '473fad26b0f729', false, false, NULL, '2022-05-14 16:44:30', 1, 0, '2022-05-14 14:16:57.265253', '2022-05-14 16:44:30');
INSERT INTO public.talks (id, user_id, title, slug, archived, closed, closed_at, last_comment_created_at, comments_count, liked_count, created_at, updated_at) VALUES (17, 1, '社会保障審議会（介護保険部会）', '35d4a739a6ad7f', false, false, NULL, '2022-05-14 15:43:26', 1, 0, '2022-05-14 15:43:05.270537', '2022-05-14 15:43:26');


--
-- Name: talks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.talks_id_seq', 18, true);


--
-- PostgreSQL database dump complete
--

