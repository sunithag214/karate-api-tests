package runner;

import com.intuit.karate.junit5.Karate;

public class SampleTest {
    
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:features/product-crud.feature");
    }
}