<h1 style="color:royalblue;">🏋️‍♀️ FitGuardians 🏋️‍♂️</h1>
<br />
<h2>프로젝트 주제 : 헬스장 회원 관리 시스템</h2>
<br />
<h2>What is "FitGuardians"❓ </h2>

![로고](https://github.com/user-attachments/assets/e2dd507a-be3e-4b67-bf27-c07d450b7e10)
<p>
Fit은 건강한 상태를, Guardians는 <b style="color:royalblue;">수호자</b> 혹은 
<b style="color:royalblue;">보호자</b>를 의미한다. <br/>
트레이너가 회원의 건강을 지키고 체력을 증진시킬 수 있는 “수호자”와 같은 역할을 한다는 의미에서 이름을 명명하였다. 트레이너와 회원이 건강한 라이프스타일을 위해 서로를 돕고 협력하는 기원을 담고 있다.
</p>

<h3>프로젝트 기획 의도</h3>
<p>
  &nbsp;&nbsp;건강과 체력증진은 시대를 초월하고 많은 사람에게 중요한 목표가 되었다. 특히나 오랜 시간 책상에 앉아 사무일을 하는 것이 다반사인 현대인은 체력과 건강을 지키는 것이 매우 취약한 환경에 직면한다. 이에 따라 전문적인 트레이너의 훈련과 역할이 더욱 중요해지고 있다. <br/>
 &nbsp;&nbsp;FitGuardians는 트레이너가 회원의 건강과 신체 정보를 종합하여 가장 적합한 운동 및 식단 프로그램을 계획할 수 있도록 돕고, 회원의 체력 변화를 모니터링하는데 초점을 두고 있는 헬스장 회원관리 시스템이다. 트레이너는 회원의 운동 진행상황을 파악하고, 필요에 따라 운동 계획을 조정하여 회원의 최상의 상태를 이끌어 올릴 수 있다.
</p>

<h3>클라이언트 요구사항 분석</h3>
<p>메인화면(대시보드), 스케줄 캘린더, 운동&식단 설정 화면은 트레이너와 회원 모두에게 있는 카테고리이나 세부 기능 및 내용에 차이가 있어 분리하였다.</p>
<ul>
    <li>스케줄 캘린더 : 트레이너는 회원의 PT스케줄, 운동 혹은 식단에 대한 플래너를 캘린더에 작성,표시할 수 있다. 회원은 트레이너가 설정한 PT스케줄과 운동&식단 플래너를 확인하고 캘린더에 기록할 수 있다.</li>
    <li>운동 추천 : 운동 플래너 화면으로 트레이너는 PT이외 자유 운동 시간에 회원의 건강상태를 고려하여 적절한 운동 기간과 프로그램을 계획하여 저장할 수 있다. API를 통해 ai가 회원의 스케줄을 작성하는 서비스, 운동을 검색하는 서비스를 추가하였다. 회원은 트레이너가 설정한 플래너를 조회하며, 자유 운동 시 회원이 임의로 한 운동을 기록하여 트레이너에게 보여줄 수 있다.</li>
    <li>식단 추천 : 식단 플래너 화면으로 트레이너는 식단 서비스가 필요한 회원을 대상으로 적절한 플랜을 계획하여 회원에게 보여줄 수 있다. 회원은 트레이너로부터 받은 식단 플래너에 대해 의견을 보낼 수 있으며 엑셀로 출력할 수 있다. 혹은 자신이 임의로 시행한 식단을 기록하여 트레이너에게 보여질 수 있다.</li>
</ul>

![요구사항분석-공통](https://github.com/user-attachments/assets/9c2fee2a-f9d4-4677-9f1c-53edaaee011d)

![요구사항분석-트레이너](https://github.com/user-attachments/assets/a495d4f3-7da4-4673-afa5-6be54091e1c8)

![요구사항분석-회원](https://github.com/user-attachments/assets/41a44378-5990-4524-aaae-c127e28b4d30)

<h3>유스케이스 다이어그램</h3>

![유스케이스](https://github.com/user-attachments/assets/a8186f9d-79a9-4bac-95cf-701f215d4bac)

<h3>DB 설계도(ERD)</h3>

![fitguardianserd](https://github.com/user-attachments/assets/e51be120-463e-4ce1-9feb-eabeaf983016)

<h3>사이트 맵</h3>

<p>
&nbsp; &nbsp;웹사이트에 접속하면 로그인 화면이 먼저 화면에 나온다. 회원 · 트레이너에 따라 구분하여 로그인창을 만들었으며, 로그인 전 사용자의 신분 상태를 체크하여 해당 계정으로 접속하면 메인(대시보드)화면이 나온다. <br />
&nbsp; &nbsp;사용자의 상태에 따라 대시보드의 내용이 나뉘어진다. 회원은 자신의 개인, 신체정보를 수정할 수 있으며 트레이너와 1:1 채팅을 통해 건의 및 문의사항을 전달할 수 있다. <br />
&nbsp; &nbsp; 회원은 qr 코드를 통해 헬스장의 입퇴실을 기록할 수 있으며, 트레이너가 설정한 자신의 맞춤형 운동, 식단 프로그램을 확인하고 수행여부에 대해 체크할 수 있다. <br />
&nbsp; &nbsp; 트레이너는 측정을 통한 회원의 신체 정보 변화(체질량지수, 골격근량 등)를 기록할 수 있으며 스케줄 캘린더에 회원의 프로그램 기간, 식단, PT스케줄을 반영할 수 있다.</p>

![사이트맵](https://github.com/user-attachments/assets/b57a07ed-0f14-47cc-ad24-9b0a5ca2ea0f)

<h3>개발 환경</h3>

|구분|기술|
|:------:|:---:|
|**Front-end**|JavaScript, jQuery, HTML5, CSS3, Ajax|
|**Back-end**|Java 11, JSP & Servlet |
|**DBMS**|Oracle|
|**Framework**|Mybatis, Spring Framework|
|**Tool**|STS, Visual Studio Code |
|**Environment**|Windows 10, Apache Tomcat 9.0 |
|**Management**|GitHub, Notion|


<h3>팀원 소개</h3>
<br />
<b>김상우, 김종열, 박경원, 이주영(조장👑), 이준영</b> <br /><br />

<ol>
    🔴 김상우
    <div>회원 가입, 로그인, qr코드인증 , 일정생성, 마이페이지, 카카오톡으로 qr코드 전송시키기</div> 
    <br />
    🟠 김종열
    <div> 회원-트레이너 1:1 채팅, 위치에 따른 날씨 정보, 현재 위치 및 주소 입력에 따른 주변 헬스장 위치 마커로 표시</div>
    <br />
    🟡 박경원
    <div> 회원가입 추가 정보 입력, (카카오, 네이버, 구글) API를 활용한 소셜 로그인 및 회원가입</div>
    <br />
    🟢 이주영
    <div> 트레이너 · 회원 운동 플래너 입력 및 조회, openAPI를 이용한 AI운동플래너 생성 서비스 및 PDF 출력, 운동 검색 기능, 트레이너 · 회원 메인 대시보드 구성, 회원의 키 · 몸무게 등을 이용한 골격근량, 체질량지수(BMI), 체지방량 계산 및 조회</div>
    <br />
    🔵 이준영
    <div>open API를 이용한 트레이너 · 회원 식단 플래너 서비스, 트레이너 조회, 토스 openAPI를 이용한 회원권 구매</div>
    <br />
</ol>

<h3>느낀점</h3>
<ol>
    🔴 김상우
    <div> &nbsp; &nbsp;파이널 프로젝트를 하면서 세미 때는 하지 못하거나 하고싶었던 기능들을 구현할 수 있는
기회가 되어서 좋았습니다. 특히 회원 가입시 qr코드를 생성하는기능, 이메일인증번호를 전송하는기능, 캘린더를 생성해서 톡캘린더에 연동하는 기능등 다양한 기능들을 구현하고 잘 작동되어서 뿌듯했습니다. </div> 
    <br />
    🟠 김종열
    <div> &nbsp; &nbsp;파이널 프로젝트 시작부터 예상치 못한 일이 생겨서 프로젝트를 뒤엎고 새로 시작을 해야 했는데 이로 인해서 적지 않은 시간이 허비 됐음에도 불구하고 팀원들이 각자 업무 분담을 확실히 하여 기대 이상으로 프로젝트의 성과가 좋았습니다. 실제 코드를 짜기 전 단계에 있었던 작업들이 개인적으로 많이 부족했는데 좋은 팀원을 만나 부족한 부분을 채울 수 있어서 좋았습니다. <br />
     &nbsp; &nbsp;맡았던 코드 구현 부분은 세미 프로젝트때는 안해봤던 각종 API를 이용한 지도 마커 구현, 날씨 구현과 1:1 채팅을 구현해보았는데 충분한 지식이 없었기 때문에 많은 시행착오가 있었지만 결국 구현에 성공하고 오류없이 실행 된다는 점은 이번 프로젝트에서 얻은 가장 큰 수확일 것입니다.<br /> &nbsp; &nbsp;추가로 이번 프로젝트를 진행하면서 로컬 개발환경을 인터넷에 안전하게 노출 시켜 https 작업환경이 필요한 기능을 구현 가능하게 도와주는 ngrok나 API 요청 작성 및 전송을 도와주는 postman 등의 교육중에 배우지 않았던 프로그램을 사용해보았던 경험은 앞으로의 프로젝트 진행에 있어 큰 도움이 될 것이라 생각합니다. </div>
    <br />
    🟡 박경원
    <div> &nbsp; &nbsp; 이 프로젝트에서 소셜 로그인과 그리고 회원가입을 할 수 있는 기능을 맡았던 부분이 상당히 도전적이였습니다. 그럼에도 이에 흔들리지 않고 원하는 기능을 최소한 일부라도 확실하게 동작하는 모습을 보고싶어, 밤 늦게까지 자발적으로 몰두하게 되었습니다. 특히 3가지의 각기 다른 양식으로 사용자의 데이터가 담긴 JSON으로부터 DB에 연결하기 위해 데이터를 가공하는 작업 역시 쉽지 않았습니다, 이 어렵게 느껴진 기능도 결국엔 구현하기 성공해서 흡족했습니다. <br />
    &nbsp; &nbsp;그 중에서 가장 인상 깊었던 일은 데이터를 가공하면서 해당 데이터를 DB로 옮길 때 다른 기능에 문제가 발생하지 않도록 어떻게 하면 좋을지 생각해봤을 때, 회원 테이블을 수정하지 않고 유연하게 필수 데이터를 넣는 것을 우선시 했습니다. 이로인해 필수 데이터인 ID와 비밀번호를 완전히 랜덤하게 생성되게끔 해서 만들었던 부분, 거기다 식별하기 편하게 ID앞에 식별 문자를 둔 것이 상당히 기억에 남습니다. 서술한 내용과는 별개로 프로젝트를 진행하는 동안 팀원들과에 소통도 잦아, 서로간의 협동심도 매우 좋게 느껴졌습니다.<br /> 
     &nbsp; &nbsp;이 경험을 통해서 API를 이용한 데이터 가공처리는 능숙하게 다룰 수 있는 자신감이 생겼고 또한 팀 내부의 고충사항도 각별히 신경쓰며 코드를 짜는 유연성 또한 길러지게 되어, 추후 프로젝트 진행 시 이는 좋은 이점으로 남기게 될 것으로 보입니다.</div>
    <br />
    🟢 이주영
    <div> &nbsp; &nbsp; 모든 것이 미숙했던 조장으로서 팀원들이 많은 도움을 주고 적극적으로 협력해준 것에 대해 감사함을 느꼈습니다. 또한 조장은 기능 개발 뿐 만 아니라 버전 관리, git 사용 등에서도 능숙해야 함을 깨달았으며, 더욱 실력있는 개발자가 되기 위해 많은 노력이 필요함을 깨달았습니다. <br />
    &nbsp; &nbsp; 다양한 API를 사용하는 경험을 하고 싶어 해외 API 사이트인 Rapid API, Ninja API를 사용하였는데, 구현 중에는 데이터 가공 처리 등 많은 우여곡절이 있었지만 원하는 서비스를 구현할 수 있어서 보람을 느꼈습니다. API 뿐 만 아니라 Chart.js, FullCalendar, Apache PDFBox와 같은 새로운 라이브러리를 사용하였는데, 수업시간 외에 배운 라이브러리들을 혼자 검색하고 공부하여 서비스 구현에 성공하였다는 점 자체가 만족스러웠고, 의미있는 경험이라 생각하였습니다. </div>
    <br />
    🔵 이준영
    <div></div>
    <br />
</ol>

<h3>아쉬운 점</h3>
<ol>
    🟠 김종열
    <div> &nbsp; &nbsp; 코드를 구현하기 전에 좀 더 해당 기능 구현에 대한 지식을 가진 상태로 했다면 어떨까 싶었습니다. 예를들어 1:1 채팅 프로그램을 짜는 동안 이에 대한 지식이 부족해 계속해서 무언가를 추가하게 되었고, 이로 인해서 발생하는 필요치 않은 시간 소모가 많았습니다. DB를 다시 짠다던가, 모델을 전체적으로 수정을 해야 한다던가 하는 일이 많이 생겨서 효율적으로 프로젝트를 진행하지 못해서 만족스러운 기능 구현에는 실패한 것 같아서 아쉽습니다. 이로 인해서 채팅기능의 구현의 경우 웹소켓을 이용하여 하려고 했으나, 예상치 못한 에러와 db 수정, 미흡한 지식 등을 이유로 시간이 부족하다고 판단하여 AJAX로 구현한 점 또한 많이 아쉬웠습니다.  <br />
    &nbsp; &nbsp; 또한 프로젝트 진행 중 생각하지 못한 오류에 대해 대처가 빠르지 못해서 많은 시간을 허비한 적이 있는데, 코드 구현 뿐만 아니라 통합개발환경에 대한 이해가 부족해서 생긴 오류들이나 git에 대한 부족한 지식으로 생긴 오류에 대해서 빠르게 대처하지 못했고, 이로 인해서 팀 전체에 악영향을 끼친 것 같아서 아쉬웠습니다. 단순히 프로그램 코드를 잘 짜는 것만이 중요한게 아니라, 개발 도구나 프로젝트에 기능 구현을 위한 사전 지식 또한 빈틈없이 채우는 것이 중요하다는 것을 깨달았습니다. </div>
    <br />
    🟡 박경원
    <div> &nbsp; &nbsp; 소셜 로그인 기능 자체 부분은 상당히 코드가 난해해 보입니다, 같은 팀원들이 해당 로직을 봤을 때 한 눈에 보기가 다소 어렵다고 피드백을 준 바가 있었는데, 이를 위한 공통으로 사용할 수 있는 메소드를 다수 제작을 했음에도 불구하고 코드 작성자 본인이 보기에도 상당히 해당 코드들을 보기 힘들다는 것을 알 수 있어, 코드들의 가독성에 대해 다소 아쉬웠습니다. <br/>
    &nbsp; &nbsp;추가적으로 담당하던 파트는 상기에서 작성된 소셜 로그인 뿐만이 아닌 ZOOM API를 응용해서 '화상 PT'를 구현하는 것도 계획이 짜여져 있었지만, 당장 급한 소셜 로그인에 대한 기능 구현을 우선 목표로 만들다가 프로젝트의 데드라인 직전까지 소셜 로그인에 대한 디버깅을 반드시 진행해야하기에, '화상 PT'기능을 끝내 구현하지 못한점이 아쉬움이 남았습니다. 이 아쉬운 부분에 대한 개선할 점으로, 소셜 로그인 기능을 위한 작업을 할 때 코드의 간결성과 가독성, 그리고 ‘화상 PT’에 대한 초점으로 다른 우선시 되는 기능의 최소 구현 속도에 눈여겨 보아야될 것으로 보입니다.</div>
    <br />
    🟢 이주영
    <div>  &nbsp; &nbsp;API 설계와 코드 구현이 익숙하지 않아 당초 계획이었던 ‘카카오톡을 이용한 회원의 운동 플래너 전송’을 하지 못한 점,  Apache PDF를 다루면서 데이터를 보기 좋게 출력하지 못했던 점이 가장 아쉬웠습니다. 세미때와 다른 개념을 다시 공부하고, 새로운 라이브러리와 API를 다루는 것이 다소 미숙했던 이번 프로젝트를 통해서, Spring에 대한 개념 복습과 공식 문서를 읽는 연습이 필요함을 깨달았습니다. <br />
    &nbsp; &nbsp; 수업시간 외의 라이브러리와 openAPI를 사용했다는 것에서 의의를 두었으며, 다음 프로젝트에선 더욱 성숙한 서비스 제공을 위해 다양한 cdn, 라이브러리 등을 숙지하고 공부하기로 결심하였습니다.</div>
    <br />
    
</ol>

<hr/>
<h3>프로젝트 구현</h3>


<details>
  <summary style="list-style:none">🔴 김상우</summary>
  <!-- 내용 -->
</details>


<details>
  <summary style="list-style:none">🟠 김종열</summary>
  <h4>내 위치 기준 헬스장 조회</h4>

![헬스장](https://github.com/user-attachments/assets/45e3e0a2-50f2-4cf4-9510-b78b1b4df06b)

![헬스장2](https://github.com/user-attachments/assets/b762df65-1bc7-42a2-8754-2f879a6c2e6d)

![헬스장3](https://github.com/user-attachments/assets/a6c9eee2-aa6f-4ad4-b964-68e818a239c4)

  <h4>날씨 API</h4>

  ![날씨](https://github.com/user-attachments/assets/3f376522-7d9d-4f37-b9a9-7ac81ed53862)

  <h4>채팅</h4>

  <p>1:1 채팅 트레이너 검색</p>
  
![트레이너 검색](https://github.com/user-attachments/assets/261c4908-c2a8-44d3-bc0d-a56ec096cd51)

  <p>채팅리스트 및 각 채팅창 열기</p>

  ![트레이너 채팅](https://github.com/user-attachments/assets/f2aa806e-6923-4644-a6a8-c7a86affd37d)

  <p>채팅 화면</p>

  ![채팅](https://github.com/user-attachments/assets/da2fca72-bdf3-4f2e-bf15-cd09597f08a8)

  <p>채팅 내 파일 업로드 및 다운로드</p>

  ![채팅 파일삽입](https://github.com/user-attachments/assets/d7ba1860-67e4-461e-babc-86d1b0e59ff5)

</details>

<details>
  <summary style="list-style:none">🟡 박경원</summary>
  <h4>API 회원가입, 로그인</h4>

  <p>카카오 API</p>

  ![카카오로그인](https://github.com/user-attachments/assets/c72df8e7-a47f-4126-aa43-6dbeaf2e1392)

  <p>네이버 API</p>

  ![네이버로그인](https://github.com/user-attachments/assets/9f7d2799-c546-486a-b85d-522a958bdd03)

  <p>구글 API</p>

  ![구글로그인](https://github.com/user-attachments/assets/8d7f4032-0992-411b-9f96-b0c47c69f597)

  <h4>추가정보 입력란</h4>

  ![추가정보입력](https://github.com/user-attachments/assets/fdf0476c-4271-4131-8bf8-c689d34ecccb)
  
</details>

<details>
  <summary style="list-style:none"> 🟢 이주영</summary>
  <h4>운동 플래너 작성(트레이너)</h4>

  <p>회원 선택</p>
  
  ![트레이너의 회원선택](https://github.com/user-attachments/assets/451373c6-0e27-4e6a-b5c0-b24345ca79c7)

  <p>운동 플랜 추가</p>

  ![트레이너운동입력](https://github.com/user-attachments/assets/9a3f2f66-4865-431e-8550-d10e443727e0)

  <p>운동 플랜 조회</p>
  &lt; 트레이너 화면

  ![트레이너운동조회(트레이너)](https://github.com/user-attachments/assets/7d8c53db-6929-4fe1-86a1-152fb13d8c92)
  
  &lt; 회원 화면

  ![트레이너운동조회(회원)](https://github.com/user-attachments/assets/82f42234-a2f6-4bba-b262-66d6dd08bc40)

  <p>운동 플랜 삭제</p>
  
  ![트레이너운동삭제](https://github.com/user-attachments/assets/0d444071-39e2-4671-a523-f77911e1d025)

  </ol>

  <h4>운동 플래너 작성(회원)</h4>

  <p>회원 운동 플래너 작성</p>

  ![회원운동입력](https://github.com/user-attachments/assets/bb31dd18-1439-419d-9114-1cd0416abfd9)

  <p>회원 운동 플래너 조회</p>
  &lt; 트레이너 화면

  ![회원운동조회(트레이너)](https://github.com/user-attachments/assets/59b0c0ef-e20b-4b50-b264-ce6d4885398c)

  &lt; 회원 화면

  ![회원운동조회(회원)](https://github.com/user-attachments/assets/80fe6cf7-ec68-49a7-95ce-e85bc233c3fd)

  <p>회원 운동 플래너 삭제</p>

  ![회원운동삭제](https://github.com/user-attachments/assets/01a346b7-f8d4-44d9-91e1-2ca6196afaad)

  <h4>AI 운동스케줄 생성</h4>

  <p>스케줄 생성</p>

  ![AI운동플랜](https://github.com/user-attachments/assets/b754e06d-73ca-441c-ab38-9b7c7f19bdb4)

  <p>PDF 다운로드</p>

  ![pdf출력](https://github.com/user-attachments/assets/59e05e0f-dd41-4e90-8fe6-b16a9309cf2a)

  <h4>운동 검색</h4>

  ![운동검색](https://github.com/user-attachments/assets/a9d5a986-1229-4dc4-96e3-33244ed476e9)
  
</details>

<details>
  <summary style="list-style:none">🔵 이준영</summary>
  <!-- 내용 -->
</details>
