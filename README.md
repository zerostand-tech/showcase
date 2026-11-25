# ALT9 Game Showcase

개인 프로젝트를 전시하고 EXE / APK 설치 파일을 내려받게 하는 페이지입니다.
서버 없이 GitHub Pages만으로 동작합니다.

## 구성

| 파일 | 역할 |
| --- | --- |
| `index.html` | 사이트 전체 (방문자 화면 + 관리자 화면) |
| `projects.json` | 프로젝트 목록. 관리자 화면에서 저장하면 자동으로 갱신됩니다 |
| `files/<프로젝트ID>/` | 올린 설치 파일·이미지가 저장되는 곳 (자동 생성) |

## 배포 (최초 1회)

1. GitHub에서 새 저장소를 만듭니다. (예: `showcase`)
2. `index.html`, `projects.json`, `README.md`를 저장소에 올립니다.
3. 저장소 **Settings → Pages → Build and deployment**에서
   Source를 **Deploy from a branch**, Branch를 **main / (root)** 로 지정하고 저장합니다.
4. 1~2분 뒤 `https://<계정>.github.io/<저장소>/` 로 접속합니다.

## 프로젝트 올리기 (본인만 가능)

1. GitHub **Settings → Developer settings → Personal access tokens → Fine-grained tokens**에서 토큰을 만듭니다.
   - Repository access: **Only select repositories** → 이 저장소만 선택
   - Permissions: **Contents → Read and write**
2. 사이트 맨 아래 **관리자**를 누르고 토큰을 입력합니다.
3. 오른쪽 위 **+ 새 프로젝트**에서 제목, 설명, 썸네일, EXE/APK를 넣고 저장합니다.
4. 프로젝트 카드를 열면 **수정 / 삭제** 버튼이 보입니다.

저장하면 저장소에 커밋이 생기고, 방문자 화면에는 1~2분 뒤 반영됩니다.
토큰이 없는 사람은 저장소에 쓸 수 없으므로 업로드할 수 없습니다.

## 웹(HTML) 프로젝트

"웹 실행 파일" 칸에 HTML 파일을 올리면 상세 화면에 **웹에서 실행** 버튼이 생기고, 새 탭에서 바로 열립니다.
웹 빌드처럼 파일이 여러 개(.html, .js, .wasm 등)면 전부 한 번에 선택해서 올립니다. 하위 폴더가 있는 빌드는 지원하지 않습니다.

## 설치 파일 크기

- **50MB 이하**: 관리자 화면에서 바로 올립니다.
- **50MB 초과**: 저장소 **Releases**에 파일을 올린 뒤, 그 파일의 다운로드 주소를
  관리자 화면의 "다운로드 링크" 칸에 붙여 넣습니다. (Releases는 파일당 2GB까지)

## 사이트 이름 바꾸기

`projects.json`의 `site.title`(왼쪽 위 로고 글자)과 `site.footer`(맨 아래 문구)를 수정합니다.

## 공개 범위

GitHub Pages는 기본적으로 주소를 아는 누구나 볼 수 있습니다.
사내 구성원만 보게 하려면 GitHub Enterprise Cloud의 비공개 Pages 기능이 필요합니다.

## 좋아요 · 설치 수

가입이 필요 없는 공개 카운터 서비스(https://abacus.jasoncameron.dev)에 숫자만 저장합니다. 따로 설정할 것은 없습니다.

- 좋아요는 브라우저당 1번이고 취소할 수 없습니다. 설치 수는 설치·실행 버튼을 누른 횟수입니다(같은 방문에서는 1번만 셉니다).
- 누구나 주소만 알면 숫자를 올릴 수 있는 방식이라 조작을 막을 수 없습니다. 참고용 숫자로만 봐 주세요.
- 외부 무료 서비스라 중단될 수 있습니다. 그 경우 숫자만 0으로 보이고 사이트는 정상 동작합니다.
- 6개월 동안 아무도 보지 않은 프로젝트의 숫자는 서비스에서 삭제됩니다.
- 끄려면 `index.html`의 `CONFIG.counterNamespace`를 빈 값으로 바꿉니다.

### 댓글까지 쓰려면 (선택)

댓글은 글을 저장할 데이터베이스가 필요합니다. 아래처럼 Supabase를 연결하면 카운터 대신 Supabase를 쓰고 댓글과 좋아요 취소도 켜집니다.

1. https://supabase.com 에서 가입하고 새 프로젝트를 만듭니다. (Region은 Seoul 권장)
2. 왼쪽 메뉴 **SQL Editor**에 이 저장소의 `supabase.sql` 내용을 전부 붙여 넣고 **Run** 합니다.
3. **Project Settings → API Keys**에서 **Project URL**과 **Publishable key**(`sb_publishable_...`)를 복사합니다.
4. `index.html` 위쪽 `CONFIG`의 `supabaseUrl`, `supabaseKey`에 넣고 커밋합니다.

- 댓글을 지우려면 Supabase 대시보드 **Table Editor → comments**에서 해당 줄을 삭제합니다.
- Supabase 무료 플랜은 7일간 사용이 없으면 프로젝트가 일시 중지됩니다. 대시보드에서 다시 켤 수 있습니다.
