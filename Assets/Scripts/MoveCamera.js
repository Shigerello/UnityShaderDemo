#pragma strict

private var rotation : Vector3;
private var time : float;

function Start () {
    time = 0;
    rotation = transform.rotation.eulerAngles;
}

function Update () {
    time += Time.deltaTime;
    if (time >= 360) time -= 360;
    var curRotation = rotation + Vector3.up*3*Mathf.Sin(time);
    transform.rotation.eulerAngles = curRotation;
}
