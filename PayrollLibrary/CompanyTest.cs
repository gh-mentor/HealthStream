using NUnit.Framework;

namespace PayrollLibrary.Tests
{
    [TestFixture]
    public class CompanyTests
    {
        [Test]
        public void AddDepartment_ShouldAddDepartmentToList()
        {
            // Arrange
            var company = new Company("Acme Corporation", new CompanyAddress("123 Main St", "City", "State", "12345"), "555-1234");
            var department = new Department(1, "Sales");

            // Act
            company.AddDepartment(department);

            // Assert
            Assert.Contains(department, company.Departments);
        }

        [Test]
        public void AddDepartment_ShouldThrowArgumentException_WhenDepartmentIdIsZero()
        {
            // Arrange
            var company = new Company("Acme Corporation", new CompanyAddress("123 Main St", "City", "State", "12345"), "555-1234");
            var department = new Department(0, "Sales");

            // Act & Assert
            Assert.Throws<ArgumentException>(() => company.AddDepartment(department));
        }
    }
}