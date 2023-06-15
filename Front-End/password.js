document.getElementById('passwordButton').addEventListener('click', function () {
   var passwordModal = new bootstrap.Modal(document.getElementById('passwordModal'));
   passwordModal.show();
});

document.getElementById('submitButton').addEventListener('click', function () {
   var password = document.getElementById('passwordInput').value;
   // 비밀번호 확인 로직을 추가하세요
   // 비밀번호가 맞으면 원하는 동작을 수행하고, 틀리면 알림을 표시하세요

   // 모달 창 닫기
   var passwordModal = bootstrap.Modal.getInstance(document.getElementById('passwordModal'));
   passwordModal.hide();

   // 비밀번호 입력 필드 초기화
   document.getElementById('passwordInput').value = '';
});

document.getElementById('passwordModal').addEventListener('hidden.bs.modal', function () {
   // 모달 창이 닫힐 때 비밀번호 입력 필드 초기화
   document.getElementById('passwordInput').value = '';
});