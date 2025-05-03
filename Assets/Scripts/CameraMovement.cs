using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    public Transform lowLookAt;
    public Transform highLookAt;

    public float radius = 5f;
    public float spriralSpeed = 1f;
    public float vertFrequency = 0.5f;

    private float angle = 0f;
    private float counter = 0f;

    private void Update()
    {
        angle += spriralSpeed * Time.deltaTime;
        counter += vertFrequency * Time.deltaTime;

        float verticalFactor = (Mathf.Sin(counter) + 1f) / 2f;
        verticalFactor = Mathf.Clamp(verticalFactor, 0.1f, 0.9f);
        float height = verticalFactor * radius;

        float x = Mathf.Cos(angle) * radius * Mathf.Cos(verticalFactor * Mathf.PI / 2);
        float z = Mathf.Sin(angle) * radius * Mathf.Cos(verticalFactor * Mathf.PI / 2);

        float y = Mathf.Sin(verticalFactor * Mathf.PI / 2) * radius;

        transform.position = new Vector3(x, y, z);

        float t = Mathf.Pow(verticalFactor, 0.1f);
        Vector3 lookAtPoint = Vector3.Lerp(highLookAt.position, lowLookAt.position, t);

        transform.LookAt(lookAtPoint);
    }
}
