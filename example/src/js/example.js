import { Exif } from '@capacitor-community&#x2F;exif';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    Exif.echo({ value: inputValue })
}
