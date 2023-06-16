document.getElementById('passwordButton').addEventListener('click', function () {
   var passwordModal = new bootstrap.Modal(document.getElementById('passwordModal'));
   passwordModal.show();
});

document.getElementById('submitButton').addEventListener('click', function () {
   var password = document.getElementById('passwordInput').value;
   // 비밀번호 확인 로직을 추가하세요
   // 비밀번호가 맞으면 원하는 동작을 수행하고, 틀리면 알림을 표시하세요

   if (nameInput.value.trim() === '' || textInput.value.trim() === '') {
      // 입력 필드가 하나라도 비어있을 경우 모달 창을 닫지 않고 함수를 종료
      return;
   } else {


      // 모달 창 닫기
      var passwordModal = bootstrap.Modal.getInstance(document.getElementById('passwordModal'));
      passwordModal.hide();

      // 비밀번호 입력 필드 초기화
      document.getElementById('passwordInput').querySelector('form').reset();
      // document.getElementById('replyName').value = '';
      // document.getElementById('replyText').value = '';
   }

});

document.getElementById('passwordModal').addEventListener('hidden.bs.modal', function () {
   // 모달 창이 닫힐 때 비밀번호 입력 필드 초기화
   document.getElementById('passwordInput').value = '';
});