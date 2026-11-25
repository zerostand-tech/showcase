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

## 설치 파일 크기

- **50MB 이하**: 관리자 화면에서 바로 올립니다.
- **50MB 초과**: 저장소 **Releases**에 파일을 올린 뒤, 그 파일의 다운로드 주소를
  관리자 화면의 "다운로드 링크" 칸에 붙여 넣습니다. (Releases는 파일당 2GB까지)

## 사이트 이름 바꾸기

`projects.json`의 `site.title`(왼쪽 위 로고 글자)과 `site.footer`(맨 아래 문구)를 수정합니다.

## 공개 범위

GitHub Pages는 기본적으로 주소를 아는 누구나 볼 수 있습니다.
사내 구성원만 보게 하려면 GitHub Enterprise Cloud의 비공개 Pages 기능이 필요합니다.
