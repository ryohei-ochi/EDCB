#181212
#_EDCBX_HIDE_
#�t�@�C�������^�C�g���o�[�ɕ\��
#(Get-Host).UI.RawUI.WindowTitle="$($MyInvocation.MyCommand.Name):${env:FileName}.ts"

#####################���[�U�ݒ�####################################################################################################

<#
�ݒ�̏��������[��(PowerShell�̎d�l)
X ����
$Toggle= �C�R�[���c�����܂܂ɂ��Ȃ��I�e�X�g��X�ɂ�����I
O ��k
$Toggle=$False ����
$Toggle=$false �啶���������̋�ʂ͂Ȃ�
$Toggle=0 ����
$Toggle=$True �L��
$Toggle=1 �L��
$Toggle = $true =��+=�̑O��ɃX�y�[�X�������Ă��ǂ�(�R�[�f�B���O�I�ɂ͂��������������ۂ�)
$Toggle ��
$Toggle=$Null null
#$Toggle �R�����g
X ����
$Path=C:\DTV\EncLog �G���[�o��
$Path="C:\DTV\�G���R�[�h�@���O" �����ł��邩������Ȃ����Ǌ�{�I�Ƀp�X�ɔ��p��S�p�̃X�y�[�X�͔񐄏�
O ��k
$Path='C:\DTV\EncLog' �ϐ���������΃��e�����ł�k
$Path = "C:\DTV\EncLog" �����̂��
X ����
$Arg='-quality $ArgQual' �V���O���N�H�[�g�ł�'$ArgQual'�Ƃ���������ɂȂ��Ă��܂��̂ŕϐ��̒��g���W�J����Ȃ���I
$Arg="-vf bwdif=0:-1:1$ArgScale" �ϐ����ƃR�[�h������킵����I
$Arg="-i "${FilePath}"" �_�u���N�I�[�g�͈̔͂��Œ��Œ�����><
$Arg='-i "${FilePath}"' �ϐ����W�J����Ȃ���I
O ��k
$Arg="-quality $ArgQual" �_�u���N�H�[�g�ł͕ϐ��̒��g���W�J�����
$Arg="-vf bwdif=0:-1:1${ArgScale}" ${}���g����
$Arg="-i `"${FilePath}`"" �o�b�N�N�I�[�g`�ŃG�X�P�[�v���悤
X ����
$logcnt_max="1000" ���������̂�String(������)����Ȃ���Iint(���l)����I
O ��k
$logcnt_max=1000
$logcnt_max=[int]"1000"
$Size=200GB
$Size="200GB" OK�炵��(^^;;
$Size=0.2TB
#>

#ffmpeg.exe�Affprobe.exe������f�B���N�g��
$ffpath='C:\ffmpeg\bin'

#--------------------���O--------------------
#$False=�����A$True=�L��
$log_toggle=$True
#���O�o�̓f�B���N�g��
$log_path='D:\Rec\EncLog'
#���O���c����
$logcnt_max=1000

#--------------------ts�̎����폜--------------------
#臒l�𒴉߂����ꍇ�A$False=�e�ʌx���A$True=ts�������폜
$TsFolderRound=$False
#�^��t�H���_�̏��
$ts_folder_max=150GB

#--------------------mp4�̎����폜--------------------
#臒l�𒴉߂����ꍇ�A$False=�e�ʌx���A$True=mp4�������폜
$Mp4FolderRound=$True
#mp4�p�t�H���_�̏��
$mp4_folder_max=25GB

#--------------------jpg�o��--------------------
#$True=�L�� $False=����
$jpg_toggle=$False
#�A��jpg���o�͂���t�H���_�p�̃f�B���N�g��
$jpg_path='C:\Users\sbn\Desktop\TVTest'
#jpg�o�͂����������\��L�[���[�h(���jpg�o�͂���ꍇ: $jpg_addkey='')
$jpg_addkey='�C���^�[�~�b�V����|�₪�ČN�ɂȂ�|�F����̓��}�g|�A���V�[�[�V����|beatless'
#�����\��L�[���[�h�Ɉ����|�������ꍇ�Ɏ��s����R�[�h �g�p�\:$ArgScale(����1440px�̏ꍇ�̂�",scale=1920:1080"���i�[�����B�摜�ɂ�SAR�Ƃ������̂�)
function ImageEncode {
    #�A��jpg�o�͂����
    <#
    #�o�̓f�B���N�g��
    New-Item "${jpg_path}\${env:FileName}" -ItemType Directory
    #�v���Z�X���s
    Invoke-Process -File "${ffpath}\ffmpeg.exe" -Arg "-y -hide_banner -nostats -an -skip_frame nokey -i `"${env:FilePath}`" -vf bwdif=0:-1:1,pp=ac,hqdn3d=2.0${ArgScale} -f image2 -q:v 0 -vsync 0 `"$jpg_path\$env:FileName\%05d.jpg`""
    #>

    #waifu2x�������Ŏg�p���邱�Ƃ͈ꉞ�\�ł����A�������Ԃ��񌻎��I�ł�

    #ts��ێ��p�f�B���N�g���ɃR�s�[�����
    Copy-Item -LiteralPath "${env:FilePath}" "D:\tsfiles" -ErrorAction SilentlyContinue
}

#--------------------ts�t�@�C���T�C�Y����--------------------
#�f���̕i��������ts�t�@�C���T�C�Y�ɂ���ēK���I�ɕς���($ArgQual)
#�K���i���@�\ $False=����(�G���R�[�h�������ɋL�q)�A$True=�ʏ�E��i����臒l�Ő؂�ւ�
$tssize_toggle=$Fals
#臒l
$tssize_max=20GB #���炢����������
#�ʏ�i��(LA-ICQ:27,x265:25)
$quality_normal='-init_qpI 23 -init_qpP 27 -init_qpB 27'
#��i��(LA-ICQ:30,x265:27)
$quality_low='-init_qpI 25 -init_qpP 30 -init_qpB 32'

#--------------------�f���A�����m�̔���--------------------
#�����������f���A�����m���ۂ��ŕς���($ArgAudio)
#�f���A�����m
$audio_dualmono='-c:a aac -b:a 128k -ac 1 -filter_complex channelsplit'
#�ʏ�
$audio_normal='-c:a copy' #�G���[�͏o�邪���s���Ȃ�
#$audio_normal='-c:a aac -b:a 256k' �ăG���R
#$audio_normal='-c:a copy -bsf:a aac_adtstoasc' ���s�����ExitCode=0�ׁ̈A�񐄏�

#--------------------PID�̔���--------------------
#�K�v��PID���擾��-map�����ɉ�����($ArgPid)

#--------------------�G���R�[�h--------------------
#mp4�̈ꎞ�o�̓f�B���N�g��
$tmp_folder_path='D:\Rec\tmp'
#mp4�ۑ�(Backup and Sync�A���[�J���ۑ�)�p�f�B���N�g��
$mp4_folder_path='D:\Rec\mp4'
#��O�f�B���N�g��(���[�v���Ă�ffmpeg�̏����Ɏ��s�Amp4��10GB���傫���ꍇ etc�c��ts�Ats.program.txt�Ats.err�Amp4��ޔ�)
$err_folder_path='D:\Rec\Err'
#mp4��10GB�t�@�C���T�C�Y��� $True=�L�� $False=����
$googledrive=$True
#mp4�pffmpeg���� 
<#
-File: ���s�t�@�C���̃p�X
-Arg: ����
    $ArgAudio(�G���R���s���Ȃ��ׂɕK�{)
    $ArgQual(�G���R�[�h�������ɋL�q���i����r�b�g���[�g���Œ肷��ꍇ�s�v)
    $ArgPid(�G���R���s���Ȃ��ׂɕK�{)
-Priority: �v���Z�X�D��x MSDN��Process.PriorityClass�Q�� (Normal,Idle,High,RealTime,BelowNormal,AboveNormal) ���K�{�ł͂Ȃ�
-Affinity: �g�p����_���R�A�̎w�� MSDN��Process.ProcessorAffinity�Q�� �R�A5(10000)�`12(100000000000)���g�p=0000111111110000(2�i)=4080(10�i)=0xFF0(16�i) ���K�{�ł͂Ȃ�
NVEnc H.264 VBR MinQP
-Arg "-y -hide_banner -nostats -fflags +discardcorrupt -i `"${env:FilePath}`" ${ArgAudio} -vf bwdif=0:-1:1 -c:v h264_nvenc -preset:v slow -profile:v high -rc:v vbr_minqp -rc-lookahead 32 -spatial-aq 1 -aq-strength 1 -qmin:v 23 -qmax:v 25 -b:v 1500k -maxrate:v 3500k -pix_fmt yuv420p ${ArgPid} -movflags +faststart `"${tmp_folder_path}\${env:FileName}.mp4`""
QSV H.264 LA-ICQ
-Arg "-y -hide_banner -nostats -analyzeduration 30M -probesize 100M -fflags +discardcorrupt -ss 5 -i `"${env:FilePath}`" ${ArgAudio} -vf bwdif=0:-1:1,pp=ac,hqdn3d=2.0 -global_quality ${ArgQual} -c:v h264_qsv -preset:v veryslow -g 300 -bf 6 -refs 4 -b_strategy 1 -look_ahead 1 -look_ahead_depth 60 -pix_fmt nv12 -bsf:v h264_metadata=colour_primaries=1:transfer_characteristics=1:matrix_coefficients=1 ${ArgPid} -movflags +faststart `"${tmp_folder_path}\${env:FileName}.mp4`""
x265 fast
-Arg "-y -hide_banner -nostats -analyzeduration 30M -probesize 100M -fflags +discardcorrupt -i `"${env:FilePath}`" ${ArgAudio} -vf bwdif=0:-1:1,pp=ac -c:v libx265 -crf ${ArgQual} -preset:v fast -g 15 -bf 2 -refs 4 -pix_fmt yuv420p -bsf:v hevc_metadata=colour_primaries=1:transfer_characteristics=1:matrix_coefficients=1 ${ArgPid} -movflags +faststart `"${tmp_folder_path}\${env:FileName}.mp4`""
x265 fast bel9r inspire
-Arg "-y -hide_banner -nostats -analyzeduration 30M -probesize 100M -fflags +discardcorrupt -i `"${env:FilePath}`" ${ArgAudio} -vf bwdif=0:-1:1,pp=ac -c:v libx265 -preset:v fast -x265-params crf=${ArgQual}:rc-lookahead=40:psy-rd=0.3:keyint=15:no-open-gop:bframes=2:rect=1:amp=1:me=umh:subme=3:ref=3:rd=3 -pix_fmt yuv420p -bsf:v hevc_metadata=colour_primaries=1:transfer_characteristics=1:matrix_coefficients=1 ${ArgPid} -movflags +faststart `"${tmp_folder_path}\${env:FileName}.mp4`""
x264 placebo by bel9r
-Arg "-y -hide_banner -nostats -analyzeduration 30M -probesize 100M -fflags +discardcorrupt -i `"${env:FilePath}`" ${ArgAudio} -vf bwdif=0:-1:1,pp=ac -c:v libx264 -preset:v placebo -x264-params crf=${ArgQual}:rc-lookahead=60:qpmin=5:qpmax=40:qpstep=16:qcomp=0.85:mbtree=0:vbv-bufsize=31250:vbv-maxrate=25000:aq-strength=0.35:psy-rd=0.35:keyint=300:bframes=6:partitions=p8x8,b8x8,i8x8,i4x4:merange=64:ref=4:no-dct-decimate=1 -pix_fmt yuv420p -bsf:v h264_metadata=colour_primaries=1:transfer_characteristics=1:matrix_coefficients=1 ${ArgPid} -movflags +faststart `"${tmp_folder_path}\${env:FileName}.mp4`""
#>
function VideoEncode {
    #hevc_nvenc constqp (qpI,P,B��ts�t�@�C���T�C�Y���ʂ��Q��)
    Invoke-Process -File "${ffpath}\ffmpeg.exe" -Arg "-y -hide_banner -nostats -analyzeduration 30M -probesize 100M -fflags +discardcorrupt -i `"${env:FilePath}`" -s 1280x720 -vcodec libx264 -acodec aac ${ArgPid} `"${tmp_folder_path}\${env:FileName}.mp4`""
}

#--------------------Post--------------------
#$False=Error���̂݁A$True=�펞 Twitter�ADiscord��Post
$InfoPostToggle=$False

#Twitter�@�\ $False=�����A$True=�L��
$tweet_toggle=$False
#ruby.exe
$ruby_path='C:\Ruby25-x64\bin\ruby.exe'
#tweet.rb
$tweet_rb_path='C:\DTV\EDCB\tweet.rb'
#SSL�ؖ���(���ϐ�)
$env:ssl_cert_file='C:\DTV\EDCB\cacert.pem'

#Discord�@�\ $False=�����A$True=�L��
$discord_toggle=$False
#webhook url
$hookUrl='https://discordapp.com/api/webhooks/XXXXXXXXXX'

#BalloonTip�@�\ $False=�����A$True=�L��
$balloontip_toggle=$True

<#
�G���[���b�Z�[�W�ꗗ
�E[EDCB] �^�掸�s�ɂ��G���R�[�h�s��: ts�t�@�C��������(�p�X���n����Ȃ�)�ꍇ�B�^�掸�s�H
�E[EDCB] PID�̔��ʕs��: �X�g���[���̉�͂����s�ȑO�ɕs�\�BDrop�ߑ�or�X�N�����u���������s�H
�E[GoogleDrive] 10GB�ȏ�̈׃A�b�v���[�h�ł��܂���: GoogleDrive�̎d�l�ɍ��킹��B
�E[h264_qsv] device failed (-17): QSV�̃G���[�B���[�v���ĕ��A�����݂�����s�����ꍇ�B
�E[mpegts] �R�[�f�b�N�p�����[�^��������܂���: PID���ʂ���n���ꂽPID���K�؂łȂ�orffmpeg����Ή��̃X�g���[���B
�E[aac] ��Ή��̃`�����l�����C�A�E�g: ffmpeg4.0�`�f���A�����m�����Ȃ��Ƃ��]���̈����ł͈����Ȃ��Ȃ����B
�E[-c:a aac] PID�̔��ʂɎ��s: -c:a aac���B�w��T�[�r�X�̂�(�S�T�[�r�X�łȂ�)�^��ɂȂ��Ă��Ȃ���ΕK�������B�܂���ʂ�̃X�g���[���ɑΉ��������������ǋN���邩������Ȃ��B
�E[-c:a copy] PID�̔��ʂɎ��s: -c:a copy���B��ɓ����B
�E[-c:a aac] PID�̔��ʂɎ��s�H ExitCode:0: -c:a aac���Bffmpeg�̏I���R�[�h��0�����ُ킪����H�ꍇ�B
�E[-c:a copy] -c:a aac��-ss 1�Ŏ����� ExitCode:0: -c:a copy���B��ɓ����B
�E[FFmpeg] �����Ȉ���
�E�s���ȃG���[
#>

#########################################################################################################################

#====================Post�֐�====================
function Post {
    param
    (
        [bool]$exc,
        [bool]$toggle,
        [string]$content,
        [string]$tipicon,
        [string]$tiptitle
    )
    #��O�B�����폜���L���̏ꍇ�Ats�Ats.program.txt�Ats.err�Amp4��ޔ�
    if ($exc)
    {
        if ($TsFolderRound) {
            Copy-Item -LiteralPath "${env:FilePath}" "${err_folder_path}" -ErrorAction SilentlyContinue
            Copy-Item -LiteralPath "${env:FilePath}.program.txt" "${err_folder_path}" -ErrorAction SilentlyContinue
            Copy-Item -LiteralPath "${env:FilePath}.err" "${err_folder_path}" -ErrorAction SilentlyContinue
        }
        if ($Mp4FolderRound) {
            Copy-Item -LiteralPath "${tmp_folder_path}\${env:FileName}.mp4" "${err_folder_path}" -ErrorAction SilentlyContinue
        }
    }
    #Error�������łȂ��AInfo����Post�ł���悤�ɂ���g�O��
    if ($toggle)
    {
        #Twitter�x��
        if ($tweet_toggle) {
            $env:content = $content
            &"$ruby_path" "$tweet_rb_path"
            #Start-Process "${ruby_path}" "${tweet_rb_path}" -WindowStyle Hidden -Wait
        }
        #Discord�x��
        if ($discord_toggle) {
            $payload=[PSCustomObject]@{
                content = $content
            }
            $payload=($payload | ConvertTo-Json)
            $payload=[System.Text.Encoding]::UTF8.GetBytes($payload)
            Invoke-RestMethod -Uri $hookUrl -Method Post -Body $payload
        }
    }
    #BalloonTip
    if ($balloontip_toggle) {
        #�����TipIcon�݂̂��g�p��
        #[System.Windows.Forms.ToolTipIcon] | Get-Member -Static -Type Property
        $balloon.BalloonTipIcon=[System.Windows.Forms.ToolTipIcon]::$tipicon
        #�\������^�C�g��
        $balloon.BalloonTipTitle=$tiptitle
        #�\�����郁�b�Z�[�W
        $balloon.BalloonTipText=$content
        #balloontip_toggle=1�Ȃ�5000�~���b�o���[���`�b�v�\��
        $balloon.ShowBalloonTip(5000)
        #5�b�҂���
        Start-Sleep -Seconds 5
    }
    #�^�X�N�g���C�A�C�R����\��(�ُ�I�����͎��s���ꂸ�g���C�ɖS�삪�c��d�l)
    $balloon.Visible=$False
}

#�����\��Ȃ�I��
if ($env:RecMode -eq 4) {
    return "�����\��̈׏I��"
}
if ("${env:FilePath}" -eq $null) {
    Post -Exc $True -Toggle $True -Content "Error:${env:Title}`n[EDCB] �^�掸�s�ɂ��G���R�[�h�s��" -TipIcon 'Error' -TipTitle '�^�掸�s'
}

#====================Invoke-Process�֐�====================
#ffmpeg�A&ffmpeg�A.\ffmpeg:ffmpeg�������𐳂����F�����Ȃ�(�t�@�C�������炢�Ȃ�-f mpegts�ōs���邯�ǂ��������ł�)
#Start-Process ffmpeg:-NoNewWindow��Write-Host�H-RedirectStandardOutput�AError�̓t�@�C���̂݁A-PassThru��ExitCode�͎󂯎��Ă�.StandardOutput�AError�͎󂯎��Ȃ��d�l
function Invoke-Process {
    param
    (
        [string]$priority,
        [int]$affinity,
        [string]$file,
        [string]$arg
    )
    Write-Output "Invoke-Process:$file $arg"

    #�ݒ�
    #ProcessStartInfo�N���X���C���X�^���X��
    $psi=New-Object System.Diagnostics.ProcessStartInfo
    #�A�v���P�[�V�����t�@�C����
    $psi.FileName = $file
    #����
    $psi.Arguments = $arg
    #�W���G���[�o�͂����𓯊��o��(����:$true��1�����ɂ��Ȃ��ƃf�b�h���b�N���܂�)
    $psi.UseShellExecute = $false
    $psi.RedirectStandardInput = $false
    $psi.RedirectStandardOutput = $false
    $psi.RedirectStandardError = $true
    $psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden

    #���s
    #Process�N���X���C���X�^���X��
    $p=New-Object System.Diagnostics.Process
    #�ݒ��ǂݍ���
    $p.StartInfo = $psi
    #�v���Z�X�J�n
    $p.Start() > $Null
    #�v���Z�b�T�e�a��
    if ($affinity)
    {
        #(Get-Process -Id $p.Id).ProcessorAffinity=[int]"$Affinity"
        $p.ProcessorAffinity = [int]"$affinity"
    }
    #�v���Z�X�D��x
    if ($priority)
    {
        $p.PriorityClass = $priority
    }
    #�W���G���[�o�͂��v���Z�X�I���܂œǂ�
    $script:StdErr = $Null
    while (!$p.HasExited)
    {
        $script:StdErr += "$($p.StandardError.ReadLine())`n"
    }
    #�v���Z�X�̕W���G���[�o�͂�ϐ��Ɋi�[(����:WaitForExit�̑O�ɏ����Ȃ��ƃf�b�h���b�N���܂�)
    #$script:StdErr=$p.StandardError.ReadToEnd()
    #�v���Z�X�I���܂őҋ@
    #$p.WaitForExit()
    #�I���R�[�h��ϐ��Ɋi�[
    $script:ExitCode = $p.ExitCode
    #���\�[�X���J��
    $p.Close()
}

#====================NotifyIcon====================
#System.Windows.Forms�N���X��PowerShell�Z�b�V�����ɒǉ�
Add-Type -AssemblyName System.Windows.Forms
#NotifyIcon�N���X���C���X�^���X��
$balloon=New-Object System.Windows.Forms.NotifyIcon
#powershell�̃A�C�R�����g�p
$balloon.Icon=[System.Drawing.Icon]::ExtractAssociatedIcon('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe')
#NotifyIcon.Text��64�����𒴂���Ɨ�O�AString.Substring�̊J�n�l~�I���l���������𒴂���Ɨ�O
switch (("$($MyInvocation.MyCommand.Name):${env:FileName}.ts").Length) {
    {$_ -ge 64} {$TextLength="63"}
    {$_ -lt 64} {$TextLength="$_"}
}
#�^�X�N�g���C�A�C�R���̃q���g�Ƀt�@�C������\��
$balloon.Text=([string]($MyInvocation.MyCommand.Name) + ":${env:FileName}.ts").SubString(0,$TextLength)
#�^�X�N�g���C�A�C�R���\��
$balloon.Visible=$True

#���O�L�����ANotifyIcon�N���b�N�Ń��O������̃e�L�X�g�G�f�B�^�ŊJ��
if ($log_toggle)
{
    $balloon.add_Click({
        if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left)
        {
            &"${log_path}\${env:FileName}.txt"
        }
    })
}

#====================���O====================
#���O�̃\�[�g��: (sls -path "$log_path\*.txt" 'faild' -SimpleMatch).Path
#log_toggle=$True�Ȃ�Ύ��s
if ($log_toggle) {
    #���O���J�n
    Start-Transcript -LiteralPath "${log_path}\${env:FileName}.txt"
    #�^��p�A�v���̋N�������擾
    #$RecCount=(Get-Process -ErrorAction 0 "EpgDataCap_bon","TVTest").Count
    #Write-Output "�����^�搔:$RecCount"
    #Get-ChildItem�Ń��O�t�H���_��txt�t�@�C�����擾�A�X�V���~���Ń\�[�g���Alogcnt_max��΂��AForEach-Object��Remove-Item���[�v
    Get-ChildItem "${log_path}\*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -Skip $logcnt_max | ForEach-Object {
        Remove-Item -LiteralPath "$_"
        Write-Output "���O�폜:$_"
    }
}


#====================ts�Emp4�̎����폜====================
#�t�H���_�̍��v�T�C�Y��ݒ�l�ȉ��Ɋۂߍ��ފ֐�
function FolderRound {
    param
    (
        [bool]$toggle,
        [string]$ext,
        [string]$path,
        [string]$round
    )
    if ($toggle)
    {
        #�����l
        $delcnt=-1
        #�K��1��͎��s�A�t�H���_���̐V�����t�@�C����Skip���鐔$i�𑝂₵�Ă�����$maintsize��$round�ȉ��Ɋۂߍ��ރ��[�v
        do {
            $delcnt++
            $maintsize=(Get-ChildItem "$path\*.$ext" | Sort-Object LastWriteTime -Descending | Select-Object -Skip $delcnt | Measure-Object -Sum Length).Sum
        } while ($maintsize -gt $round)
        #���Skip�����t�@�C�������ۂɍ폜
        Get-ChildItem "$path\*.$ext" | Sort-Object LastWriteTime | Select-Object -First $delcnt | ForEach-Object {
            #ts��mp4���폜
            Remove-Item -LiteralPath "$path\$($_.BaseName).$ext" -ErrorAction SilentlyContinue
            $dellog="�폜:$($_.BaseName).$ext"
            #ts���폜���̏ꍇ�A������ts.program.txt�Ats.err���폜
            if ("$ext" -eq "ts") {
                Remove-Item -LiteralPath "$path\$($_.BaseName).$ext.program.txt" -ErrorAction SilentlyContinue
                Remove-Item -LiteralPath "$path\$($_.BaseName).$ext.err" -ErrorAction SilentlyContinue
                $dellog+="�A.program.txt�A.err"
            }
            Write-Output $dellog
        }
        Write-Output "${ext}�t�H���_:$([math]::round(${maintsize}/1GB,2))GB"
    } elseif (!($toggle))
    {
        #���ߎ��̌x��
        if ($((Get-ChildItem "$path" | Measure-Object -Sum Length).Sum) -gt $round) {
            $err_detail="`n[FolderRound] ${ext}�f�B���N�g����${round}�𒴉�"
        }
    }

}
#ts
FolderRound -Toggle $TsFolderRound -Ext "ts" -Path "$env:FolderPath" -Round $ts_folder_max
#mp4
FolderRound -Toggle $Mp4FolderRound -Ext "mp4" -Path "$mp4_folder_path" -Round $mp4_folder_max
#�ԑg���t�@�C�����폜
Remove-Item -LiteralPath "${env:FilePath}.program.txt" -ErrorAction SilentlyContinue

#====================jpg�o��====================
#jpg�o�͋@�\���L��(jpg_toggle=1)����env:Addkey(�����\�񎞂̃L�[���[�h)��jpg_addkey(�w��̕���)���܂܂�Ă���ꍇ�͘A��jpg���o��
if (($jpg_toggle) -And ("$env:Addkey" -match "$jpg_addkey")) {
    Write-Output "jpg�o��"
    #��TS�̉���1920��1440�����ׂ�
    $ts_width=[xml](&"${ffpath}\ffprobe.exe" -v quiet -i "${env:FilePath}" -show_entries stream=width -print_format xml 2>&1)
    $ts_width=$ts_width.ffprobe.streams.stream.width
    #SAR��(1440x1080�����z�肵�ĂȂ�����)�ɂ��t�B���^�ݒ�Ajpg�o��
    if ("$ts_width" -eq "1440") {
        $ArgScale=',scale=1920:1080'
    }
    #jpg�pffmpeg������x���W�J
    ImageEncode
}

#====================ts�t�@�C���T�C�Y����====================
#ts�t�@�C���T�C�Y���擾
$ts_size=(Get-ChildItem -LiteralPath "${env:FilePath}").Length
if ($tssize_toggle) {
    #臒l$tssize_max�ȉ��Ȃ�ʏ�i��$quality_normal�A���傫���Ȃ��i��$quality_low
    switch ($ts_size) {
        {$_ -le $tssize_max} {$ArgQual="$quality_normal"}
        {$_ -gt $tssize_max} {$ArgQual="$quality_low"}
    }
    Write-Output "ArgQual:$ArgQual"
}

#====================�f���A�����m�̔���====================
#�ԑg���t�@�C��������f���A�����m�Ƃ��������񂪂����True�A�����񂪂Ȃ��ꍇ��False�A�ԑg���t�@�C�����������Null
if (Get-Content -LiteralPath "${env:FilePath}.program.txt" | Select-String -SimpleMatch '�f���A�����m' -quiet) {
    $ArgAudio=$audio_dualmono
} else {
    $ArgAudio=$audio_normal
}
Write-Output "ArgAudio:$ArgAudio"

#====================PID�̔���====================
#PID�����̐ݒ�
#ffprobe��codec_type,height,id���\�[�g
$programs = [xml](&"$ffpath\ffprobe.exe" -v quiet -i "${env:FilePath}" -show_entries stream=codec_type,height,id,channels -print_format xml 2>&1)
$programs.ffprobe.streams.stream
$programs.ffprobe.streams.stream | foreach {
    #�𑜓x�̑傫��Video�X�g���[����I��
    #xml�̗v�f��String�Ȃ̂�int�ɂ���K�v����
    if (($_.codec_type -eq "video") -And ($_.height -ne "0") -And ([int]($_.height) -gt [int]($otherheight)))
    {
        $otherheight = $_.height
        $ArgPid = "-map i:$($_.id)"
    }
}
#Video��PID�̐擪(0x1..)�ƈ�v����Audio�X�g���[���������ɒǉ�
$programs.ffprobe.streams.stream | foreach {
    if (($_.codec_type -eq "audio") -And ($_.channels -ne "0") -And ($($_.id).Substring(0,3) -eq $ArgPid.Substring(7,3)))
    {
        $ArgPid += " -map i:$($_.id)"
    }
}
Write-Output "ArgPid:$ArgPid"

#====================�G���R�[�h====================
#�J�E���g��0�Ƀ��Z�b�g
$cnt=0
#�I���R�[�h��1�����[�v�J�E���g��50�����܂ł̊ԁA�G���R�[�h�����݂�
do {
    $cnt++
    #�Ď��s������N�[���^�C����ǉ�
    if ($cnt -ge 2) {
        Start-Sleep -s 60
    }
    #�G���R mp4�pffmpeg������x���W�J
    VideoEncode
    #�G���R1��ڂƐ�����(ExitCode:0)�̃��O�����ŏ\��
    if (($cnt -le 1) -Or ($ExitCode -eq 0)) {
        #�v���Z�X�̕W���G���[�o�͂��V�F���̕W���o�͂ɏo��
        Write-Output $StdErr
        #�G���R���mp4�̃t�@�C���T�C�Y
        $mp4_size=$(Get-ChildItem -LiteralPath "${tmp_folder_path}\${env:FileName}.mp4").Length
    }
} while (($ExitCode -eq 1) -And ($cnt -lt 50))
#�ŏI�I�ȃG���R�[�h�񐔁A�I���R�[�h�A�t�@�C���T�C�Y
Write-Output "�G���R�[�h��:$cnt"
Write-Output "ExitCode:$ExitCode"
$PostFileSize="`nts:$([math]::round(${ts_size}/1GB,2))GB mp4:$([math]::round(${mp4_size}/1MB,0))MB"
$PostFileSize

#====================Backup and Sync====================
#Invoke-Process����n���ꂽ$StdErr����X�y�[�X������
$StdErr=($StdErr -replace " ","")
#ffmpeg�̏I���R�[�h�Amp4�̃t�@�C���T�C�Y�ɂ���������
if ($ExitCode -gt 0)
{
    #$StdErr���\�[�g��Post���e�����߂�
    switch ($StdErr)
    {
        {$_ -match 'Errorduringencoding:devicefailed'} {$err_detail+="`n[h264_qsv] device failed (-17)"}
        {$_ -match 'Couldnotfindcodecparameters'} {$err_detail+="`n[mpegts] PID�̔��ʂɎ��s"}
        {$_ -match 'Unsupportedchannellayout'} {$err_detail+="`n[aac] ��Ή��̃`�����l�����C�A�E�g"}
        {$_ -match 'Toomanypacketsbuffered'} {$err_detail+="`n[-c:a aac] PID�̔��ʂɎ��s"}
        {$_ -match 'Inputpackettoosmall'} {$err_detail+="`n[-c:a copy] PID�̔��ʂɎ��s"}
        {$_ -match 'Invalidargument'} {$err_detail+="`n[FFmpeg] �����Ȉ���"}
        default {$err_detail+="`n�s���ȃG���["}
    }
    #Twitter�ADiscord�ABalloonTip
    Post -Exc $True -Toggle $True -Content "Error:${env:FileName}.ts${err_detail}${PostFileSize}" -TipIcon 'Error' -TipTitle '�G���R�[�h���s'
} elseif (($googledrive) -And ($mp4_size -gt 10GB))
{
    #Post���e
    $err_detail+="`n[GoogleDrive] 10GB�ȏ�̈׃A�b�v���[�h�ł��܂���"
    #Twitter�ADiscord�ABalloonTip
    Post -Exc $True -Toggle $True -Content "Error:${env:FileName}.ts${err_detail}${PostFileSize}" -TipIcon 'Error' -TipTitle '�A�b�v���[�h���s'
} else
{
    #mp4��mp4_folder_path�ɓ�����
    Move-Item -LiteralPath "$tmp_folder_path\$env:FileName.mp4" "$mp4_folder_path"
    #�G���[���b�Z�[�W���i�[����Ă����TipIcon��Warning�ɕς���
    if ($err_detail)
    {
        $TipIcon='Warning'
    } else
    {
        $TipIcon='Info'
    }
    #Twitter�ADiscord�ABalloonTip
    Post -Exc $False -Toggle $InfoPostToggle -Content "${env:FileName}.ts${err_detail}${PostFileSize}" -TipIcon "$TipIcon" -TipTitle '�G���R�[�h�I��'
}