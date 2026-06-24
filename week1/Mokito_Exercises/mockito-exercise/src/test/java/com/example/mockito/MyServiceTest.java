package com.example.mockito;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class MyServiceTest {

    @Test
    void testExternalApi() {

        // Creates a mock object
        ExternalApi mockApi = mock(ExternalApi.class);

        // Defines behavior of mock
        when(mockApi.getData()).thenReturn("Mock Data");

        // Injecting mock into service
        MyService service = new MyService(mockApi);

        // Calling method
        String result = service.fetchData();

        // Verify result
        assertEquals("Mock Data", result);
    }
}
