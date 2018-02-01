package com.ohhoonim.test.common;

import org.junit.Test;
import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.text.DecimalFormat;

import com.ohhoonim.common.util.Utils;

public class UtilsTest {
	@Test
	public void customNumTest() {
		
		assertThat(Utils.customNum("8888355520", "###,###"), is("8,888,355,520"));
		assertThat(Utils.customNum("520", "###,###"), is("520"));
	}
}
