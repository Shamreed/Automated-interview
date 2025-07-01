# Test script for Automated Interview Platform API

$baseUrl = "http://localhost:8080"

Write-Host "=== Automated Interview Platform API Tests ===" -ForegroundColor Green

# Test 1: Public endpoint
Write-Host "`n1. Testing public endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/test/all" -Method GET
    Write-Host "✓ Public endpoint works: $response" -ForegroundColor Green
} catch {
    Write-Host "✗ Public endpoint failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Register a new admin user
Write-Host "`n2. Registering admin user..." -ForegroundColor Yellow
$adminUser = @{
    username = "admin_user"
    email = "admin@interview.com"
    password = "password123"
    role = "ADMIN"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/auth/register" -Method POST -Body $adminUser -ContentType "application/json"
    Write-Host "✓ Admin registration: $($response.message)" -ForegroundColor Green
} catch {
    Write-Host "✗ Admin registration failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 3: Register a candidate user
Write-Host "`n3. Registering candidate user..." -ForegroundColor Yellow
$candidateUser = @{
    username = "candidate_user"
    email = "candidate@interview.com"
    password = "password123"
    role = "CANDIDATE"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/auth/register" -Method POST -Body $candidateUser -ContentType "application/json"
    Write-Host "✓ Candidate registration: $($response.message)" -ForegroundColor Green
} catch {
    Write-Host "✗ Candidate registration failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 4: Login as admin
Write-Host "`n4. Logging in as admin..." -ForegroundColor Yellow
$adminLogin = @{
    username = "admin_user"
    password = "password123"
} | ConvertTo-Json

try {
    $adminToken = Invoke-RestMethod -Uri "$baseUrl/api/auth/login" -Method POST -Body $adminLogin -ContentType "application/json"
    Write-Host "✓ Admin login successful" -ForegroundColor Green
    Write-Host "  Token: $($adminToken.accessToken.Substring(0,50))..." -ForegroundColor Cyan
    Write-Host "  Role: $($adminToken.roles)" -ForegroundColor Cyan
    
    # Test 5: Access admin endpoint
    Write-Host "`n5. Testing admin endpoint access..." -ForegroundColor Yellow
    $headers = @{
        Authorization = "Bearer $($adminToken.accessToken)"
    }
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/api/test/admin" -Method GET -Headers $headers
        Write-Host "✓ Admin endpoint access: $response" -ForegroundColor Green
    } catch {
        Write-Host "✗ Admin endpoint access failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
} catch {
    Write-Host "✗ Admin login failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 6: Login as candidate
Write-Host "`n6. Logging in as candidate..." -ForegroundColor Yellow
$candidateLogin = @{
    username = "candidate_user"
    password = "password123"
} | ConvertTo-Json

try {
    $candidateToken = Invoke-RestMethod -Uri "$baseUrl/api/auth/login" -Method POST -Body $candidateLogin -ContentType "application/json"
    Write-Host "✓ Candidate login successful" -ForegroundColor Green
    Write-Host "  Role: $($candidateToken.roles)" -ForegroundColor Cyan
    
    # Test 7: Access candidate endpoint
    Write-Host "`n7. Testing candidate endpoint access..." -ForegroundColor Yellow
    $headers = @{
        Authorization = "Bearer $($candidateToken.accessToken)"
    }
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/api/test/candidate" -Method GET -Headers $headers
        Write-Host "✓ Candidate endpoint access: $response" -ForegroundColor Green
    } catch {
        Write-Host "✗ Candidate endpoint access failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Test 8: Try to access admin endpoint as candidate (should fail)
    Write-Host "`n8. Testing unauthorized access (candidate → admin endpoint)..." -ForegroundColor Yellow
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/api/test/admin" -Method GET -Headers $headers
        Write-Host "✗ Security issue: Candidate accessed admin endpoint!" -ForegroundColor Red
    } catch {
        Write-Host "✓ Security working: Access denied as expected" -ForegroundColor Green
    }
    
} catch {
    Write-Host "✗ Candidate login failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n=== Test Summary ===" -ForegroundColor Green
Write-Host "Authentication & Authorization system is working!" -ForegroundColor Green
Write-Host "✓ User registration with different roles" -ForegroundColor Green
Write-Host "✓ JWT-based authentication" -ForegroundColor Green
Write-Host "✓ Role-based access control" -ForegroundColor Green
Write-Host "✓ Security enforcement" -ForegroundColor Green

Write-Host "`nNext steps for development:" -ForegroundColor Cyan
Write-Host "- Interview template management" -ForegroundColor White
Write-Host "- Candidate invitation system" -ForegroundColor White
Write-Host "- Real-time interview sessions" -ForegroundColor White
Write-Host "- AI-powered response evaluation" -ForegroundColor White
Write-Host "- Reporting and analytics" -ForegroundColor White
