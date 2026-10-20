/**
 * Student Management System - Main JavaScript Helpers
 */

document.addEventListener('DOMContentLoaded', function () {
    // 1. Auto-dismiss flash alerts after 4.5 seconds
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
            bsAlert.close();
        }, 4500);
    });

    // 2. Dynamic live calculation of marks percentage in marks/form.jsp
    const marksObtainedInput = document.getElementById('marksObtained');
    const maxMarksInput = document.getElementById('maxMarks');
    const pctBadge = document.getElementById('livePercentage');

    function updateLivePercentage() {
        if (!marksObtainedInput || !maxMarksInput || !pctBadge) return;
        const obtained = parseFloat(marksObtainedInput.value) || 0;
        const max = parseFloat(maxMarksInput.value) || 100;
        if (max > 0) {
            const pct = ((obtained / max) * 100).toFixed(1);
            pctBadge.textContent = pct + '%';
            if (pct >= 75) {
                pctBadge.className = 'badge bg-success';
            } else if (pct >= 50) {
                pctBadge.className = 'badge bg-primary';
            } else if (pct >= 40) {
                pctBadge.className = 'badge bg-warning text-dark';
            } else {
                pctBadge.className = 'badge bg-danger';
            }
        }
    }

    if (marksObtainedInput && maxMarksInput) {
        marksObtainedInput.addEventListener('input', updateLivePercentage);
        maxMarksInput.addEventListener('input', updateLivePercentage);
        updateLivePercentage();
    }
});

/**
 * Standard confirmation dialog for destructive delete actions
 */
function confirmAction(message) {
    return confirm(message || 'Are you sure you want to proceed?');
}

/**
 * Trigger browser print
 */
function printReport() {
    window.print();
}
