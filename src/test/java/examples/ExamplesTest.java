package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.BeforeAll;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ExamplesTest {
	
//	@Karate.Test
//    Karate testTags() {
//        return Karate.run().tags("@debug").relativeTo(getClass());
//    }
	
	 @Test
	    void testParallel() {
	        Results results = Runner.path("classpath:examples")
	                .outputCucumberJson(true)
	                .karateEnv("dev")
	                .parallel(5);
	        generateReport(results.getReportDir());
	        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
//	        assertEquals(0, results.getFailCount(), results.getErrorMessages());
	    }
	
	 public static void generateReport(String karateOutputPath) {
	        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
	        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	        Configuration config = new Configuration(new File("target"), "examples");
	        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
	        reportBuilder.generateReports();
	    }
    
    

}
