<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />

     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>토스페이먼츠 샘플 프로젝트</title>
        <style type="text/css">
    body {
  background-color: #e8f3ff;
}
.p {
  padding: 0;
  margin: 0;
  font-family: Toss Product Sans, -apple-system, BlinkMacSystemFont, Bazier Square, Noto Sans KR, Segoe UI, Apple SD Gothic Neo, Roboto, Helvetica Neue, Arial, sans-serif, Apple Color Emoji,
    Segoe UI Emoji, Segoe UI Symbol, Noto Color Emoji;
  color: #4e5968;
  word-break: keep-all;
  word-wrap: break-word;
}
.wrapper {
  max-width: 800px;
  margin: 0 auto;
}
.title {
  margin: 0 0 4px;
  font-size: 24px;
  font-weight: 600;
  color: #4e5968;
}
.box_section {
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 10px 20px rgb(0 0 0 / 1%), 0 6px 6px rgb(0 0 0 / 6%);
  padding: 50px 50px 50px 50px;
  margin-top: 30px;
  margin-right: auto;
  margin-left: auto;
  color: #333d4b;
  align-items: center;
  text-align: center;
  overflow-x: auto; /* Add this property for horizontal scrolling */
  white-space: nowrap; /* Prevent text wrapping */
}
:root {
  --inverseGrey50: #202027;
  --inverseGrey100: #2c2c35;
  --inverseGrey200: #3c3c47;
  --inverseGrey300: #4d4d59;
  --inverseGrey400: #62626d;
  --inverseGrey500: #7e7e87;
  --inverseGrey600: #9e9ea4;
  --inverseGrey700: #c3c3c6;
  --inverseGrey800: #e4e4e5;
  --inverseGrey900: #fff;
  --background: #fff;
  --darkBackground: #17171c;
  --greyBackground: #f2f4f6;
  --darkGreyBackground: #101013;
  --layeredBackground: #fff;
  --darkLayeredBackground: #202027;
  --floatBackground: #fff;
  --darkFloatBackground: #2c2c35;
  --black: #000;
  --grey50: #f9fafb;
  --grey100: #f2f4f6;
  --grey200: #e5e8eb;
  --grey300: #d1d6db;
  --grey400: #b0b8c1;
  --grey500: #8b95a1;
  --grey600: #6b7684;
  --grey700: #4e5968;
  --grey800: #333d4b;
  --grey900: #191f28;
  --greyOpacity50: rgba(0, 23, 51, 0.02);
  --greyOpacity100: rgba(2, 32, 71, 0.05);
  --greyOpacity200: rgba(0, 27, 55, 0.1);
  --greyOpacity300: rgba(0, 29, 58, 0.18);
  --greyOpacity400: rgba(0, 25, 54, 0.31);
  --greyOpacity500: rgba(3, 24, 50, 0.46);
  --greyOpacity600: rgba(0, 19, 43, 0.58);
  --greyOpacity700: rgba(3, 18, 40, 0.7);
  --greyOpacity800: rgba(0, 12, 30, 0.8);
  --greyOpacity900: rgba(2, 9, 19, 0.91);
  --white: #fff;
  --blue50: #e8f3ff;
  --blue100: #c9e2ff;
  --blue200: #90c2ff;
  --blue300: #64a8ff;
  --blue400: #4593fc;
  --blue500: #3182f6;
  --blue600: #2272eb;
  --blue700: #1b64da;
  --blue800: #1957c2;
  --blue900: #194aa6;
}

body,
html {
  font-family: Toss Product Sans, Tossface, -apple-system, BlinkMacSystemFont, Bazier Square, Noto Sans KR, Segoe UI, Apple SD Gothic Neo, Roboto, Helvetica Neue, Arial, sans-serif, Apple Color Emoji,
    Segoe UI Emoji, Segoe UI Symbol, Noto Color Emoji;
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  word-break: keep-all;
  word-wrap: break-word;
}

*,
:after,
:before {
  box-sizing: border-box;
}

.button {
  color: #f9fafb;
  background-color: #3182f6;
  margin: 30px 15px 0px 15px;
  font-size: 15px;
  font-weight: 600;
  line-height: 18px;
  white-space: nowrap;
  text-align: center;
  /* vertical-align: middle; */
  cursor: pointer;
  border: 0 solid transparent;
  user-select: none;
  transition: background 0.2s ease, color 0.1s ease;
  text-decoration: none;
  border-radius: 7px;
  padding: 11px 16px;
  width: 250px;
}

.button2 {
  color: #000000;
  background-color: #ffffff;
  margin: 30px 15px 0px 15px;
  font-size: 15px;
  font-weight: 600;
  line-height: 18px;
  white-space: nowrap;
  text-align: center;
  /* vertical-align: middle; */
  cursor: pointer;
  border: 1px solid #000000;
  user-select: none;
  transition: background 0.2s ease, color 0.1s ease;
  text-decoration: none;
  border-radius: 7px;
  padding: 11px 16px;
  width: 125px;
}

.button:hover {
  color: #fff;
  background-color: #1b64da;
}

button:disabled,
input:disabled {
  opacity: 80%;
  cursor: not-allowed;
}

button,
input,
textarea {
  font-family: Toss Product Sans, -apple-system, BlinkMacSystemFont, Bazier Square, Noto Sans KR, Segoe UI, Apple SD Gothic Neo, Roboto, Helvetica Neue, Arial, sans-serif, Apple Color Emoji,
    Segoe UI Emoji, Segoe UI Symbol, Noto Color Emoji;
}

.color--grey800 {
  color: #333d4b;
  color: var(--grey800);
}

.color--grey700 {
  color: #4e5968;
  color: var(--grey700);
}

.color--grey600 {
  color: #6b7684;
  color: var(--grey600);
}

.color--grey500 {
  color: #8b95a1;
  color: var(--grey500);
}

.color--blue500 {
  color: #3182f6;
  color: var(--blue500);
}

.color--blue700 {
  color: #1b64da;
  color: var(--blue700);
}

.bg--white {
  background-color: #fff;
  background-color: var(--white);
}

.bg--grey100 {
  background-color: #f2f4f6;
  background-color: var(--grey100);
}

.bg--greyOpacity100 {
  background-color: rgba(2, 32, 71, 0.05);
  background-color: var(--greyOpacity100);
}

.bg--greyOpacity200 {
  background-color: rgba(0, 27, 55, 0.1);
  background-color: var(--greyOpacity200);
}

.bg--blue50 {
  background-color: #e8f3ff;
  background-color: var(--blue50);
}

:root {
  --padding-base-vertical: 11px;
  --padding-base-horizontal: 16px;
  --padding-t-vertical: 4px;
  --padding-t-horizontal: 8px;
  --padding-s-vertical: 7px;
  --padding-s-horizontal: 12px;
  --padding-l-vertical: 11px;
  --padding-l-horizontal: 22px;
  --padding-xl-vertical: 18px;
  --padding-xl-horizontal: 24px;
  --padding-container-base: 48px;
}

.padding--base {
  padding: 11px 16px;
  padding: var(--padding-base-vertical) var(--padding-base-horizontal);
}

.padding--t {
  padding: 4px 8px;
  padding: var(--padding-t-vertical) var(--padding-t-horizontal);
}

.padding--s {
  padding: 7px 12px;
  padding: var(--padding-s-vertical) var(--padding-s-horizontal);
}

.padding--l {
  padding: 11px 22px;
  padding: var(--padding-l-vertical) var(--padding-l-horizontal);
}

.padding--xl {
  padding: 18px 24px;
  padding: var(--padding-xl-vertical) var(--padding-xl-horizontal);
}

.text--left {
  text-align: left;
}

.text--right {
  text-align: right;
}

.text--center {
  text-align: center;
}

.text--justify {
  text-align: justify;
}

:root {
  --line-height-base: 1.6;
  --line-height-adjust: 1.3;
  --font-size-h1: 56px;
  --font-size-h2: 48px;
  --font-size-h3: 36px;
  --font-size-h4: 32px;
  --font-size-h5: 24px;
  --font-size-h6: 20px;
  --font-size-h7: 17px;
  --font-size-p: 15px;
  --font-size-sm: 13px;
  --font-size-small: 13px;
  --font-size-xsmall: 11px;
  --font-weight-bold: bold;
  --font-weight-semibold: 600;
  --font-weight-medium: 500;
  --font-weight-regular: normal;
}

.typography {
  margin: 0;
  padding: 0;
}

.typography--h1,
.typography--h2,
.typography--h3,
.typography--h4 {
  line-height: 1.3;
  line-height: var(--line-height-adjust);
}

.typography--h1 {
  font-size: 56px;
  font-size: var(--font-size-h1);
}

.typography--h2 {
  font-size: 48px;
  font-size: var(--font-size-h2);
}

.typography--h3 {
  font-size: 36px;
  font-size: var(--font-size-h3);
}

.typography--h4 {
  font-size: 32px;
  font-size: var(--font-size-h4);
}

.typography--p {
  line-height: 1.6;
  line-height: var(--line-height-base);
  font-size: 15px;
  font-size: var(--font-size-p);
}

:root {
  --checkable-size: 24px;
  --checkable-input-top: 3px;
  --checkable-input-left: 5px;
  --checkable-input-width: 14px;
  --checkable-input-height: 10px;
  --checkable-input-svg: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1.343 4.574l4.243 4.243 7.07-7.071' fill='transparent' stroke-width='2' stroke='%23FFF' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  --checkable-label-text-padding: 8px;
  --indeterminate-checkable-input-top: 7px;
  --indeterminate-checkable-input-left: 5px;
  --indeterminate-checkable-input-width: 14px;
}

:root .checkable--small {
  --checkable-size: 20px;
  --checkable-input-top: 2px;
  --checkable-input-left: 4px;
  --checkable-input-width: 12px;
  --checkable-input-height: 9px;
  --checkable-input-svg: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1.286 3.645l3.536 3.536 5.892-5.893' fill='transparent' stroke-width='2' stroke='%23FFF' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  --indeterminate-checkable-input-top: 5px;
  --indeterminate-checkable-input-left: 4px;
  --indeterminate-checkable-input-width: 12px;
}

.checkable {
  position: relative;
  display: flex;
}

.checkable + .checkable {
  margin-top: 12px;
}

.checkable--inline {
  display: inline-block;
}

.checkable--inline + .checkable--inline {
  margin-top: 0;
  margin-left: 18px;
}

.checkable__label {
  display: inline-block;
  max-width: 100%;
  min-height: 24px;
  min-height: var(--checkable-size);
  line-height: 1.6;
  padding-left: 24px;
  padding-left: var(--checkable-size);
  margin-bottom: 0;
  padding-top: 0;
  padding-bottom: 0;
  color: #4e5968;
  color: var(--grey700);
  cursor: pointer;
}

.checkable__input {
  position: absolute;
  margin: 0 0 0 -24px;
  margin: 0 0 0 calc(var(--checkable-size) * -1);
  top: 4px;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border: none;
  cursor: pointer;
}

.checkable__input:after,
.checkable__input:before {
  content: "";
  position: absolute;
}

.checkable__input:before {
  top: -4px;
  left: 0;
  width: 24px;
  width: var(--checkable-size);
  height: 24px;
  height: var(--checkable-size);
  border: 2px solid #d1d6db;
  border: 2px solid var(--grey300);
  background-color: #fff;
  background-color: var(--white);
  transition: border-color 0.1s ease, background-color 0.1s ease;
}

.checkable__input:after {
  opacity: 0;
  transition: opacity 0.1s ease;
  top: 3px;
  top: var(--checkable-input-top);
  left: 5px;
  left: var(--checkable-input-left);
  width: 14px;
  width: var(--checkable-input-width);
  height: 10px;
  height: var(--checkable-input-height);
  background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1.343 4.574l4.243 4.243 7.07-7.071' fill='transparent' stroke-width='2' stroke='%23FFF' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-image: var(--checkable-input-svg);
  background-repeat: no-repeat;
}

.checkable__input[type="checkbox"]:indeterminate:after {
  top: 7px;
  top: var(--indeterminate-checkable-input-top);
  left: 5px;
  left: var(--indeterminate-checkable-input-left);
  width: 14px;
  width: var(--indeterminate-checkable-input-width);
  height: 0;
  border: 1px solid #fff;
  border: 1px solid var(--white);
  border-radius: 1px;
  transform: rotate(0);
}

.checkable__input:focus {
  outline: 0;
}

.checkable__input:focus:before,
.checkable__input:hover:before {
  background-color: #e8f3ff;
  background-color: var(--blue50);
  border-color: #3182f6;
  border-color: var(--blue500);
}

.checkable__input:checked:before,
.checkable__input[type="checkbox"]:indeterminate:before {
  border-color: #3182f6;
  border-color: var(--blue500);
  background-color: #3182f6;
  background-color: var(--blue500);
}

.checkable__input:checked:after,
.checkable__input[type="checkbox"]:indeterminate:after {
  opacity: 1;
}

.checkable__input:disabled:before {
  background-color: #f2f4f6;
  background-color: var(--grey100);
  border-color: rgba(0, 23, 51, 0.02);
  border-color: var(--greyOpacity50);
}

.checkable__input:disabled:checked:before,
.checkable__input:disabled[type="checkbox"]:indeterminate:before {
  background-color: #e5e8eb;
  background-color: var(--grey200);
  border-color: #e5e8eb;
  border-color: var(--grey200);
}

.checkable__input[type="checkbox"]:before {
  border-radius: 6px;
}

.checkable__input[type="radio"]:before {
  border-radius: 12px;
}

.checkable__label-text {
  display: inline-block;
  padding-left: 8px;
  padding-left: var(--checkable-label-text-padding);
}

.checkable--disabled > .checkable__input {
  cursor: not-allowed;
}

.checkable--disabled > .checkable__label {
  color: #b0b8c1;
  color: var(--grey400);
  cursor: not-allowed;
}

.checkable--read-only {
  pointer-events: none;
}

.p-flex {
  display: flex;
}

:root {
  --pGridGutter: 24px;
}

.p-grid {
  height: 100%;
  display: flex;
  flex-wrap: wrap;
  margin-right: -24px;
  margin-right: calc(var(--pGridGutter) * -1);
}

.p-grid-col {
  flex-grow: 1;
  padding-right: 24px;
  padding-right: var(--pGridGutter);
}

.p-grid-col1 {
  flex: 0 0 8.33333%;
  max-width: 8.33333%;
}

.p-grid-col2 {
  flex: 0 0 16.66667%;
  max-width: 16.66667%;
}

.p-grid-col3 {
  flex: 0 0 25%;
  max-width: 25%;
}

.p-grid-col4 {
  flex: 0 0 33.33333%;
  max-width: 33.33333%;
}

.p-grid-col5 {
  flex: 0 0 41.66667%;
  max-width: 41.66667%;
}
    
    
    
    </style>
  </head>

  <body>
    <div class="box_section" style="width: 600px">
      <img width="100px" src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" />
      <h2>결제를 완료했어요</h2>

      <div class="p-grid typography--p" style="margin-top: 50px">
        <div class="p-grid-col text--left"><b>결제금액</b></div>
        <div class="p-grid-col text--right" id="amount"></div>
      </div>
      <div class="p-grid typography--p" style="margin-top: 10px">
        <div class="p-grid-col text--left"><b>주문번호</b></div>
        <div class="p-grid-col text--right" id="orderId"></div>
      </div>
      <div class="p-grid typography--p" style="margin-top: 10px">
        <div class="p-grid-col text--left"><b>결제상품</b></div>
        <div class="p-grid-col text--right" id="paymentKey" style="white-space: initial; width: 250px"></div>
      </div>
      <div class="" style="margin-top: 30px" 	align="center">
        <button class="button p-grid-col5 fianlbtn" type="button">화면으로 돌아가기</button>
      </div>
    </div>

    <script>
      // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
      // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
      const urlParams = new URLSearchParams(window.location.search);

      // 서버로 결제 승인에 필요한 결제 정보를 보내세요.
      async function confirm() {
        var requestData = {
          paymentKey: urlParams.get("paymentKey"),
          orderId: urlParams.get("orderId"),
          amount: urlParams.get("amount"),
        };

        const response = await fetch("/confirm", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(requestData),
        });

        const json = await response.json();

        if (!response.ok) {
          // TODO: 결제 실패 비즈니스 로직을 구현하세요.
          console.log(json);
          window.location.href = `/fitguardians/fail?message=${json.message}&code=${json.code}`;
        }

        // TODO: 결제 성공 비즈니스 로직을 구현하세요.
        // console.log(json)
        return json;
      }
      confirm().then(function (data) {
        document.getElementById("response").innerHTML = `<pre>결제가 정상적으로 처리됬습니다</pre>`;
      });

      const paymentKeyElement = document.getElementById("paymentKey");
      const orderIdElement = document.getElementById("orderId");
      const amountElement = document.getElementById("amount");

      orderIdElement.textContent = urlParams.get("orderId");
      amountElement.textContent = urlParams.get("amount") + "원";
      paymentKeyElement.textContent = urlParams.get("paymentKey");
      if (window.opener) {
    console.log("부모 창에 접근 가능");
} else {
    console.log("부모 창에 접근할 수 없음");
}

	 
      $('.fianlbtn').on('click',function(){
    	  window.opener.onReceivePaymentData("결제성공");
		  window.close();
      })
		
    </script>
  </body>
</html>
